From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: ethernet performace on 3430SDP ES1.0
Date: Tue, 18 Dec 2007 18:56:07 -0600
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742902CC2122@dlee13.ent.ti.com>
References: <D0D7E940253EF8428A27241F8E3CABA3A88E0F@zeus.Combra.se>
	<3B6D69C3A9EBCA4BA5DA60D91302742902CC1C92@dlee13.ent.ti.com>
	<5573C19A4BBDB441BED2A44157E9705302D6EC49@dlee12.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <5573C19A4BBDB441BED2A44157E9705302D6EC49@dlee12.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Hunter, Jon" <jon-hunter@ti.com>, Carl Benson <Carl.Benson@combra.se>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

> > If you change your boot args to use rsize=3D1024,rsize=3D1024,tcp =
this=20
> > effect will go away.

Yes it does mostly in the sampling I know of.  TCP probably could be
skipped but it also helps if your server supports it.

> Just to confirm did you mean "rsize=3D1024,wsize=3D1024,tcp"?=20

Yes.  You might add nolock also if you're the only one on your target.

> By the way, I thought that I had read somewhere that=20
> rsize=3D1024 and wsize=3D1024 were the default. Is this something=20
> that has changed recently? I have not specified this before.=20
> However, may be I was just getting lucky!

No, I don't think that is the default.  I looked this up a few years
back when emulators were dying on live networks as their slowness made
them drop packets every now and then.  It was like 4K or 16K back then
(NFS performance pages were recommending bigger sizes to improve
performace on fast machines).  Our release notes say to have you u-boot
set this but that is something not always done.  Also if you have junk
parameters before this these will get dropped.

Regards,
Richard W.
