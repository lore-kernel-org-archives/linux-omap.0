From: "Pablo Ravest" <pravest@gmail.com>
Subject: Can't build the DSP/BIOS LINK messaging library (OSK 5912, for CCS debugging)
Date: Mon, 26 May 2008 18:03:54 -0400
Message-ID: <a4faa7a00805261503m4fad2c6aufac468e6c24e16e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:21026 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbYEZWEd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 May 2008 18:04:33 -0400
Received: by ug-out-1314.google.com with SMTP id h2so533661ugf.16
        for <linux-omap@vger.kernel.org>; Mon, 26 May 2008 15:04:32 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Hi Everyone,
I'm new to this, and probably this is a very basic problem, but I'm
still stuck with it so maybe someone can help.

I'm following the dspusersguide for CCS debugging with osk5912 and
JTAG emulator.
I can't seem to build the dsplinkmsg.pjt... here is an extract from
the log (the first lines):


> timake.exe dsplinkmsg.pjt debug
---------------------------  dsplinkmsg.pjt - Debug  ---------------------------
[mqabuf.c] "C:\CCStudio_v3.3\C5500\cgtools\bin\cl55" -g -mg -q -pdr
-pdv -pden -fr"C:/CCStudio_v3.3/boards
/osk5912/dsplink/dsp/make/OMAP/Debug"
-i"C:/CCStudio_v3.3/messaging/include"
-i"C:/CCStudio_v3.3/boards/osk5912/dsplink/dsp/make/OMAP/../../../dsp/src/mqa"
-i"C:/CCStudio_v3.3/boards/osk5912/dsplink/dsp/make/OMAP/../../../dsp/src/mqt"
-i"C:/CCStudio_v3.3/boards/osk5912/dsplink/dsp/make/OMAP/../../../dsp/inc"
-i"C:/CCStudio_v3.3/boards/osk5912/dsplink/dsp/make/OMAP/../../../dsp/inc/OMAP"
-d"_DEBUG" -d"_MSGQ_COMPONENT" -d"USE_CCS_BREAKPOINT" -ml -mn
-vcore:2.1 -@"../../make/OMAP/Debug.lkf" "mqabuf.c"
"C:/CCStudio_v3.3/boards/osk5912/dsplink/dsp/make/OMAP/../../../dsp/inc/mqabuf.h",
line 63: error #20:
       identifier "MSGQ_AllocatorFxns" is undefined
 extern MSGQ_AllocatorFxns MQABUF_FXNS ;
      ^
"mqabuf.c", line 82: error #20: identifier "MSGQ_Status" is undefined
 MSGQ_Status
 ^
"mqabuf.c", line 83: error #20: identifier "MSGQ_AllocatorHandle" is undefined
 MQABUF_open (MSGQ_AllocatorHandle mqaHandle) ;
            ^
"mqabuf.c", line 110: error #20: identifier "MSGQ_Status" is undefined
 MSGQ_Status
 ^
"mqabuf.c", line 111: error #20: identifier "MSGQ_AllocatorHandle" is undefined
 MQABUF_close (MSGQ_AllocatorHandle mqaHandle) ;
             ^
"mqabuf.c", line 145: error #20: identifier "MSGQ_AllocatorHandle" is undefined
 MQABUF_alloc (MSGQ_AllocatorHandle mqaHandle, Uint16 * size) ;
.
.
....


I have found the undefined objects in different msgq.h files in my
computer, but replacing the msgq.h located in
"C:\CCStudio_v3.3\bios_5_31_02\packages\ti\bios\include" doesn't work
because other objects become undefined.

The only thing I think is important to point out is that I'm working
with CCS 3.3 and when I tried to install the MSGQ component
(ALL-2.20-SA-to-UA-mq-1.01.00) from the osk5912 cdrom I got the
following warning:
"Setup has not found any valid products to update. Your system may be
already up-to-date or you are attempting to install a serial update
out of sequence. Setup will now abort"

Thanks

Pablo Ravest
Universidad de Chile
