From: "Leonid Liansky" <lliansky@gmail.com>
Subject: OMAP4 tiler memory issue
Date: Thu, 25 Aug 2011 15:48:33 -0400
Message-ID: <2F13A83129B34161BB666DC7D1B77455@leonidlw7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63846 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543Ab1HYTsj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Aug 2011 15:48:39 -0400
Received: by fxh19 with SMTP id 19so2016408fxh.19
        for <linux-omap@vger.kernel.org>; Thu, 25 Aug 2011 12:48:37 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I have 2 questions related to tiler memory space 2D buffers.

I am working on a project that utilizes video encoder on OMAP4 (H.264) =
using=20
OpenMax API.

In general, the encoder works as expected except that I am seeing a ver=
y=20
slow memcpy operation that copies input frame data to encoder=E2=80=99s=
 buffers=20
(takes almost 100ms to copy 720p frame). I am relying on OpenMax to all=
ocate=20
the input buffers (using OMX_AllocateBuffer). The same memcpy routine w=
orks=20
much faster when copying the same data into regular user-space allocate=
d=20
buffers (malloc based). Considering that the encoder is supposed to wor=
k at=20
the rate of 30fps, spending 100ms on each frame is too much.

I understand that OpenMax allocates tiler 2D buffers using memory manag=
er=20
and it appears that those buffers are non-cachable.

I have tried to map user-space allocated buffer into tiler memory space=
=20
(using MemMgr_Map) and then to copy frame data into the user-space memo=
ry=20
pointer. In this case memcpy works indeed faster (although still not as=
 fast=20
as I would have hoped for), but I am seeing lots of artifacts in the en=
coder=E2=80=99s=20
output. I am assuming this could be related to caching issues with the=20
mapping.

My first question is: is there a way to be able to copy encoder input d=
ata=20
in a fast way =E2=80=93 maybe there are specific requirements for alloc=
ating/mapping=20
encoder input buffers?

My second question is about tiler image rotation: what is the correct w=
ay=20
(if any) to be able to utilize tiler-based rotation on encoder=E2=80=99=
s input=20
buffers from user-space (only interested in right-angle rotations). I=20
understand that I need to calculate the correct tiler memory space offs=
et=20
for the specific rotation degree that is required. Would I be able to a=
ccess=20
the address from user-space and maybe even somehow ask the encoder to u=
se=20
the rotated image instead of the original one?

Any information/hints will be greatly appreciated (or a sample test sou=
rce=20
code).

Thank you,
Leo

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
