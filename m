From: "Dave P. Martin" <dave.martin@linaro.org>
Subject: Re: [PATCH 03/14] ARM: v6k: remove CPU_32v6K dependencies in
 asm/spinlock.h
Date: Thu, 27 Jan 2011 11:44:31 +0000
Message-ID: <20110127114431.GA3194@arm.com>
References: <AANLkTinnhivretaRHpYwCYouk-_jWKZQEo7x4sbheJVL@mail.gmail.com>
 <20110125165919.GD17286@n2100.arm.linux.org.uk>
 <AANLkTimK06nJPtQoym3HxXeDD-s4nUrN0vWjp_JcgTjx@mail.gmail.com>
 <20110125174636.GE17286@n2100.arm.linux.org.uk>
 <alpine.LFD.2.00.1101251618230.8580@xanadu.home>
 <AANLkTi=zVsr8G=eYfp7v_QQvBBDCX+Es+T-4c4Fu=QVF@mail.gmail.com>
 <alpine.LFD.2.00.1101261023470.8580@xanadu.home>
 <20110126155203.GA10141@n2100.arm.linux.org.uk>
 <AANLkTikG4bPmesNPvLGt8G+Q8YWwRzyYL3i+uL1FE=K2@mail.gmail.com>
 <alpine.LFD.2.00.1101261558470.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51313 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846Ab1A0Lon (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Jan 2011 06:44:43 -0500
Received: by bwz15 with SMTP id 15so2108145bwz.19
        for <linux-omap@vger.kernel.org>; Thu, 27 Jan 2011 03:44:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1101261558470.8580@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Dave Martin <dave.martin@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Jan 26, 2011 at 04:06:40PM -0500, Nicolas Pitre wrote:
> On Wed, 26 Jan 2011, Dave Martin wrote:
> 
> > On Wed, Jan 26, 2011 at 3:52 PM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > > So I don't think weak symbols work like we want them to.
> > >
> > 
> > That was the conclusion I came to also ... the linker seems to resolve
> > references in each object before discarding sections, so the weak
> > reference has already become concrete and section discard breaks it.
> 
> Well, I must add to the chorus.
> 
> And it seems to be impossible to obtain the name of the currently active 
> section from gas either, which would have made the conditional omission 
> of the fixup possible, or similar.
> 
> Bummer.
> 
> 
> Nicolas

I've achieved this sort of thing in the past by wrapping the assmbler.
It's not pretty though, and it's unlikely anyone would be interested
in merging such a thing...

The example below is really a hack and won't work well in the the
presence of macros or conditional assembler.  However, since gcc output
contains none of either except in inline asm, you can get away with
a surprising amount.

If it needed to be robust this could mostly be implemented in 
assembler macros, but the need to hook things like .section, combined
with gas's refusal to redefine existing directives, means that you
would have a run a script over the input first, to translate .section
and friends into something you can hook.

And implementing anything non-trivial with assembler macros, while
almost always possible (unlike crippled cpp) gets very painful and
confusing...

Cheers
---Dave

$ chmod +x gasfilter filt-as
$ PATH=$PWD:$PATH
$ arm-linux-gnueabi-gcc -wrapper $PWD/filt-as -c tst.s
$ arm-linux-gnueabi-objdump -dsh tst.o

tst.o:     file format elf32-littlearm

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00000004  00000000  00000000  00000034  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .data         00000000  00000000  00000000  00000038  2**0
                  CONTENTS, ALLOC, LOAD, DATA
  2 .bss          00000000  00000000  00000000  00000038  2**0
                  ALLOC
  3 .text.fixup   00000004  00000000  00000000  00000038  2**0
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  4 .text.init    00000008  00000000  00000000  0000003c  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  5 .text.init.fixup 00000004  00000000  00000000  00000044  2**0
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  6 .ARM.attributes 00000021  00000000  00000000  00000048  2**0
                  CONTENTS, READONLY
Contents of section .text:
 0000 00f020e3                             .. .            
Contents of section .text.fixup:
 0000 00000000                             ....            
Contents of section .text.init:
 0000 00f020e3 00f020e3                    .. ... .        
Contents of section .text.init.fixup:
 0000 04000000                             ....            
Contents of section .ARM.attributes:
 0000 41200000 00616561 62690001 16000000  A ...aeabi......
 0010 05372d41 00060a07 41080109 020a042c  .7-A....A......,
 0020 01                                   .               

Disassembly of section .text:

00000000 <main>:
   0:	e320f000 	nop	{0}

Disassembly of section .text.fixup:

00000000 <.text.fixup>:
   0:	00000000 	.word	0x00000000

Disassembly of section .text.init:

00000000 <init>:
   0:	e320f000 	nop	{0}

00000004 <__fixup_3>:
   4:	e320f000 	nop	{0}

Disassembly of section .text.init.fixup:

00000000 <.text.init.fixup>:
   0:	00000004 	.word	0x00000004

diff -Nur filt-as filt-as
--- filt-as	1970-01-01 01:00:00.000000000 +0100
+++ filt-as	2011-01-27 11:30:11.858552002 +0000
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+case "$1" in
+	as|*/as|*-as) ;;
+	*) exec "$@"
+esac
+
+real_as=$1
+shift
+
+out=a.out
+in=-
+
+while [ $# != 0 ]; do
+	case "$1" in
+		-o)
+			out=$2
+			shift
+			;;
+		*.s)
+			in=$1
+			;;
+		*)
+			args=$args\ $1
+	esac
+	shift
+done
+
+gasfilter <"$in" \
+| "$real_as" $args -o "$out"
diff -Nur gasfilter gasfilter
--- gasfilter	1970-01-01 01:00:00.000000000 +0100
+++ gasfilter	2011-01-27 11:10:01.478552002 +0000
@@ -0,0 +1,68 @@
+#!/usr/bin/perl
+
+use strict;
+
+my $xpushsection_defined;
+
+my @section_stack = ( undef );
+
+sub setsection ($$) {
+	my ($name, $line) = @_;
+
+	print ".purgem __xpushsection\n" if $xpushsection_defined;
+
+	print
+".macro __xpushsection name:req, flags
+	.pushsection \"$name.\\name\", \"\\flags\"
+.endm
+";
+
+	$section_stack[$#section_stack] = $name;
+
+	$xpushsection_defined = 1;
+
+	print $line
+}
+
+sub popsection ($)
+{
+	pop @section_stack;
+	setsection $section_stack[$#section_stack], $_[0];
+}
+
+sub pushsection ($$)
+{
+	my ($name, $line) = @_;
+
+	push @section_stack, $name;
+	setsection $name, $line;
+}
+
+sub xpushsection ($$) {
+	my ($name, $rest) = @_;
+
+	print "__xpushsection \"$name\"$rest\n"
+}
+
+sub process_line {
+	$_ = $_[0] if defined $_[0];
+
+	if (/^\s*(\.(text|data|bss))(\s|$)/) {
+		setsection $1, $_
+	} elsif (/^\s*\.section\s+([\$._0-9A-Za-z]+).*/) {
+		setsection $1, $_
+	} elsif (/^\s*\.pushsection\s+([\$._0-9A-Za-z]+).*/) {
+		pushsection $1, $_
+	} elsif (/^\s*\.popsection(\s|$)/) {
+		popsection $_
+	} elsif (/^\s*\.xpushsection\s+([\$._0-9A-Za-z]+)(.*)/) {
+		xpushsection $1, $2
+	} elsif (/^\s*\.xpopsection(\s|$)/) {
+		print ".popsection\n"
+	} else {
+		print
+	}
+}	
+
+process_line ".text\n";
+process_line while <>;
diff -Nur tst.s tst.s
--- tst.s	1970-01-01 01:00:00.000000000 +0100
+++ tst.s	2011-01-27 11:07:39.338552001 +0000
@@ -0,0 +1,23 @@
+.macro fixup
+	_fixup \@
+.endm
+
+.macro _fixup num
+__fixup_\num :
+	.xpushsection fixup, "a"
+	.long __fixup_\num
+	.xpopsection
+.endm
+
+.globl main
+main:
+	fixup
+	nop
+
+.section .text.init, "ax"
+.globl init
+init:	nop
+
+	fixup
+	nop
+
