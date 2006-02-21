From: "Menon, Nishanth" <x0nishan@ti.com>
Subject: RE: [PATCH] Alsa modularisations and support for tsc2101 2/7
Date: Tue, 21 Feb 2006 07:31:19 -0600
Message-ID: <520AB2AD990DC04082102F77CA1726381036EB@dlee03.ent.ti.com>
References: <9268368b0602200947g57ed39d6y28d4612ed4278cda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Daniel Petrini <d.pensator@gmail.com>, OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Nope, does not look a good idea to me, as we will not be able to pull =
these out for 2420/2430 platforms(unless we move it to plat). why keep =
the tsc2101/aic in platforms specific directory if:
1. it can have varied control path
2. data transfer paths?
3. defined set of apis which can be called  by an higher abstraction =
layer?
=20
I can see the transfer configuration is mainly setup from board file, =
which is an excellent idea. however for codecs.. err.. sound/... is a =
nice place for it to remain..
=20
This will allow:
1. Other platforms other than omap also to be able to use tsc2101 =
functionalilty
2. have common support for alsa and oss - i dont see oss dying a lot =
sooner ;)
why would we want to stop the cross leverage?
=20
Regards,
Nishanth Menon

________________________________

From: linux-omap-open-source-bounces@linux.omap.com on behalf of Daniel =
Petrini
Sent: Mon 2/20/2006 11:47 AM
To: OMAP-Linux
Subject: [PATCH] Alsa modularisations and support for tsc2101 2/7



ALSA Omap Patch

This patch moves codec files to mach-omap1 file and adds supports in
makefile for this

signed-off by Daniel Petrini <d.pensator@gmail.com>
signed-off by Mika Laitio <lamikr@cc.jyu.fi>

Daniel
--
INdT - Manaus - Brazil
