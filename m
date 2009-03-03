From: David Hagood <david.hagood@gmail.com>
Subject: Re: Anyone built the kernel drivers for the PowerVR under
 linux-omap-2.6?
Date: Tue, 03 Mar 2009 07:07:58 -0600
Message-ID: <1236085678.7924.48.camel@surfer>
References: <c6ef7709f9373651496b2a32ca42f571.squirrel@localhost>
	 <1D24AF54-A1B5-4BFD-BBB3-09E1BB1F0A7F@student.utwente.nl>
	 <1236083245.7924.26.camel@surfer>
	 <B3546260-AC1E-4601-BC8D-74AB9A16B144@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:48174 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbZCCNIG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Mar 2009 08:08:06 -0500
Received: by wa-out-1112.google.com with SMTP id v33so1488672wah.21
        for <linux-omap@vger.kernel.org>; Tue, 03 Mar 2009 05:08:02 -0800 (PST)
In-Reply-To: <B3546260-AC1E-4601-BC8D-74AB9A16B144@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Tue, 2009-03-03 at 13:30 +0100, Koen Kooi wrote:

OK, I apologize in advance, but that statement has pricked the festering
boil of my feelings about this matter, and I feel that I must address
it.

> Well, TI is using OE to build their new PSPs, your point is moot :)

Not really - that assumes that OE becomes the new standard for all
builds.

The reason I don't use OE is that I could never get to where I could
regenerate anything non-trivial (like Angstrom) due to errors in Bitbake
and the various OE black magic^W^W"recipes". Attempting to work through
the problems with the OE devs touched upon just about every pet peeve I
have with Free Software projects:

Me: "I cannot get this to build, here's what I am doing, here's the
script I use to set the environment variables needed for OE, here's the
errors I am getting."
Them: "I don't like the fact that you are using this temporary
environment variable to set these other variables."
Me: "OOOKAAAY, but that variable is a temporary and has nothing to do
with anything. It gets unset at the end of the script. As you can see,
the variables OE needs are set correctly."
Them: "I am going to fixate upon your use of this environment variable
and not address the problem you are having, for I don't really
understand how to fix your problem."
Me: "GRRR. OK. Fine. I set all the variables BY HAND. Here is a
transcript of my exact session. Here is THE SAME DAMN PROBLEM
happening."
Them #1: "I still don't like that you were using that temporary
variable, and will ignore the fact that you aren't using it now."
Them #2: "Oh, you are using the released version of Bitbake. Silly boy,
that version is horribly busted. Go get the newest version from
Subversion, because we feel that actually releasing fixed code is
unnecessary if you have public access to your source code control
system."
Me: "OK, I removed the released version my distro vendor has, and
installed the version from Subversion. Now it doesn't even run at all."
Them: <crickets chirp.wav>

I am sorry, but I have tried, step by step, to follow the instructions
on the OE site to reproduce Angstrom. They don't work for me. They are
incomplete and incorrect, with many of the examples being demonstrably
WRONG.

I have tried to follow the instructions on the Angstrom site (which,
BTW, are very different than the OE instructions). They, too, are
incomplete and demonstrably wrong in many cases.

Sorry, but I am NOT going to base MY project on something that I cannot
get working after several WEEKS of effort to get working.

Yes, I know "it works for me" for certain values of "me", but I cannot
get it working under bog-standard Debian, so that doesn't help me.

Don't get me wrong: I *love* Free Software. I've had far worse
experiences with commercial software like pSOS, VxWorks, and <shudder>
Windows than this. But I do feel the "it's fixed in CVS, so it's FIXED:
full stop" attitude is WRONG - if it isn't released it isn't fixed yet.
I do feel that the various Rainman-like folks who will completely ignore
the real problem to pick at an unrelated piece of lint (and thus lower
the signal to noise ratio of the channel below usability) aren't
helping. I feel the "this is broken in upstream, so we'll break out the
duct tape here rather than trying to fix the upstream" mindset is
antithetical to the idea of "Let's all SHARE the improvements".

I am just trying to help improve things so that Free Software becomes
better every day. The idea that I have to use a specific "vendor" for my
project - be that vendor Microsoft or be that vendor OpenEmbedded - just
because obvious issues aren't being fixed in a truly portable fashion is
ABSURD.



