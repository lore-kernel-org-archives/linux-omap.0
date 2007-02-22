From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: Problem running ALSA utilities
Date: Thu, 22 Feb 2007 05:16:17 -0600
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47510EFA@dlee13.ent.ti.com>
References: <45DD431E.6060400@procsys.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <45DD431E.6060400@procsys.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Priya <priya@procsys.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

As of now we don't support ASLA for TWL4030 based audio. For now the
only available option is to go with OSS :(

Regards,
Khasim

>-----Original Message-----
>From: linux-omap-open-source-bounces@linux.omap.com [mailto:linux-omap-
>open-source-bounces@linux.omap.com] On Behalf Of Priya
>Sent: Thursday, February 22, 2007 1:16 AM
>To: linux-omap-open-source@linux.omap.com
>Subject: Problem running ALSA utilities
>
>Hi,
>I am relatively new to linux. Iam trying to bring up ALSA on OMAP2430
>board. Iam using 2.6 kernel version with the ALSA driver built in. I
>have cross compiled ALSA libraries and ALSA utilities and intstalled
>them successfully.  But when i run aplay i get the following error
>
>ALSA lib pcm.c:2143:(snd_pcm_open_noupdate) Unknown PCM default
>aplay: main:508: audio open error: No such file or directory
>
>The proc/asound/ direcory does not seem to list my sound card (codec).
>
>But i see that my kernel is compiled with OSS option for my sound card
>(Trition -2 TWL4030). Can anybody please tell me how to get ALSA up for
>Trition -2 based sound system.
>
>Thanks in advance
>priya
>
>
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
