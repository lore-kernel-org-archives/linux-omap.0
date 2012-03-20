From: jean-philippe francois <jp.francois@cynove.com>
Subject: Troubleshooting DSPLINK example
Date: Tue, 20 Mar 2012 09:55:50 +0100
Message-ID: <CAGGh5h2Yh=fsi9vG2cF_AjqaR=8CVbPEdMfggZPRcxg1wKADjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60264 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965094Ab2CTIzv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Mar 2012 04:55:51 -0400
Received: by iagz16 with SMTP id z16so10712918iag.19
        for <linux-omap@vger.kernel.org>; Tue, 20 Mar 2012 01:55:50 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I am trying to have a working dsplink on a DM3730 based board.
DVSDK is 4.03
Kernel is the kernel provided by the DVSDK

What happens is the __second__ test I run, if different from
the first, fails with a MMU fault. The faulting adress vary, and is
never a "valid" address, where valid means somewhere in the
DSPLINK memory map. I checked the DSPLink Troubleshooting
page [1], and everything seems ok to me. I did not change
the memory map, but checked the tci file mentioned in [2], and
my mem command line arg is mem=3D=3D55M which should be ok.

What is strange is the first app run fine. For example in the following
test runs (dsp is powered off between each run) :

-- test # 1 --
=2E/loopgpp ./loop.out 100 1000
=2E/messagegpp ./message.out 2000 <-- faulting app

-- test #2 --
=2E/messagegpp ./message.out 2000
=2E/loopgpp ./loop.out 100 1000 <-- faulting app

-- test #3 --
=2E/messagegpp ./message.out 2000
=2E/messagegpp ./message.out 4000
=2E/loopgpp ./loop.out 100 1000 <-- faulting app
DSP MMU Error Fault!  MMU_IRQSTATUS =3D [0x1]. Virtual DSP addr
reference that generated the interrupt =3D [0xbebebeb8].

I think what leads to the MMU fault is the DSP is executing
garbage with something like this going on :
- DSP does not stop running, and when new code is loaded, at some point
old and new code is mixed, leading to fault

- Code loading works Ok, but there is a cache  or cache flush problem, =
leading
to old and new code being mixed.

Thank you for reading this, any hint on what to test next is welcome.

Jean-Philippe Fran=E7ois

[1] http://processors.wiki.ti.com/index.php/Troubleshooting_DSPLink_con=
figuration_issues
[2] http://processors.wiki.ti.com/index.php/Changing_DSPLink_Memory_Map
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
