From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: 2430 FB driver issues
Date: Thu, 19 Jul 2007 11:32:52 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274290176C1B0@dlee13.ent.ti.com>
References: <782515bb0707031706l32231cbbv34a67572068b835f@mail.gmail.com>	<468E9632.1080205@mvista.com>	<Pine.LNX.4.64.0707081657410.5848@utopia.booyaka.com><200707091204.21320.hyau@mvista.com>
	<469ECABD.4020106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <469ECABD.4020106@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Nishanth Menon <menon.nishanth@gmail.com>, Hunyue Yau <hyau@mvista.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

 > Not much useful information except that my guess is FB LCD is broken =
on
> 2430SDP as of date and it is possibly broken from the time it is
> enabled.. Since i do see Tony punching in a bunch every weekend, did
> Hunyue test with the git latest once Tony finished pushing all =
patches?
> - esp since May 25th is the time when the major clock/prcm  framework
> patches from Paul W went into git.

It is working now right?  I updated and booted my local version and all =
seems happy.

I have a random patch or two differences from the stock kernel but I'm =
not sure they matter.

Regards,
Richard W.

----------------
root@128.247.75.30:/tst# uname -a
Linux 128.247.75.30 2.6.22-omap1-g2a1c4dfb-dirty #1 PREEMPT Thu Jul 19 =
10:24:19
CDT 2007 armv6l GNU/Linux

root@128.247.75.30:/tst#./powertop
    PowerTOP version 1.0       (C) 2007 Intel Corporation

< Detailed C-state information is only available on Mobile CPUs =
(laptops) >
tail: `-190' option is obsolete; use `-n 190'
Try `tail --help' for more information.


Top causes for wakeups:
  86.7%        <interrupt> : gp timer
  11.1%        <interrupt> : eth0
   2.2%        <interrupt> : serial

Suggestion: Enable the CONFIG_USB_SUSPEND kernel configuration option.
This option will automatically disable UHCI USB when not in use, and may
save approximately 1 Watt of power.
