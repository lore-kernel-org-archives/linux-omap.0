From: CF Adad <cfadad@rocketmail.com>
Subject: Re: Question: Custom DAI driver for AM35xx using McBSP
Date: Wed, 29 Feb 2012 09:27:49 -0800 (PST)
Message-ID: <1330536469.53752.YahooMailNeo@web125203.mail.ne1.yahoo.com>
References: <1330488712.31452.YahooMailNeo@web125205.mail.ne1.yahoo.com>
Reply-To: CF Adad <cfadad@rocketmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm27-vm0.bullet.mail.ne1.yahoo.com ([98.138.91.63]:25228 "HELO
	nm27-vm0.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1031239Ab2B2R1u convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Feb 2012 12:27:50 -0500
In-Reply-To: <1330488712.31452.YahooMailNeo@web125205.mail.ne1.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

One note of clarification:

As mentioned in the email above, the only "non-standard" piece to this =
signaling is likely the "long frame sync".=A0 As shown on the modem's t=
iming diagram (posted on the E2E forums here:=A0 http://e2e.ti.com/resi=
zed-image.ashx/__size/550x0/__key/CommunityServer-Discussions-Component=
s-Files/447/2476.clk_5F00_fs_5F00_timing.jpg), the FS pulse is active (=
high) for 16 bits and then low for another 16 bits.=A0 At 8kHz, that ma=
kes the frame period 125us.=A0 All TX and RX happens simultaneously whi=
le FS is active (high), and _nothing_ happens while it is low.

We have interpretted this as requiring a frame width (FWID) of 16 [well=
, 15+1 in the McBSP] and a frame period (FPER) of 32 [or, 31+1 in the M=
cBSP].=A0 Since the AM3517 is a slave, however, we do not expect to nee=
d the SRG.=A0 So we're not sure how important these variables are to th=
e McBSP config.=A0 Should other settings be used?

We have studied the /sound/soc/omap/omap-mcbsp.c file in great detail, =
and the only place we can see a possible misconfiguration for us is in =
the calculation of framesize, which Linux uses to setup FWID and FPER.=A0=
 In the existing code, framesize is calculated as "wlen * channels".=A0=
 So, for a mono signal like ours, our frame ends up only 16 bits wide, =
not 32.=A0 We're not sure how big of deal this is, as if the code is si=
mply looking for the rising edge of the FS pulse, then it should not ma=
tter how long the FS is down for before going high again.=A0 Regardless=
, for testing, we forced the framesize calculation on line 373 of omap-=
mcbsp.c to be:

framesize =3D wlen * 2;=A0 // 32

We have tried our setup with both the modified and unmodified versions =
of omap-mcbsp.c, and in both cases TX works great and RX returns only s=
ilence (0x00 samples).

Any help would greatly be appreciated.=A0 Thanks in advance.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
