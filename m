From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: ethernet performace on 3430SDP ES1.0
Date: Tue, 18 Dec 2007 18:48:31 -0600
Message-ID: <5573C19A4BBDB441BED2A44157E9705302D6EC49@dlee12.ent.ti.com>
References: <D0D7E940253EF8428A27241F8E3CABA3A88E0F@zeus.Combra.se>
	<3B6D69C3A9EBCA4BA5DA60D91302742902CC1C92@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D91302742902CC1C92@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>, Carl Benson <Carl.Benson@combra.se>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> If you change your boot args to use rsize=3D1024,rsize=3D1024,tcp this
> effect will go away.

Just to confirm did you mean "rsize=3D1024,wsize=3D1024,tcp"?=20

By the way, I thought that I had read somewhere that rsize=3D1024 and
wsize=3D1024 were the default. Is this something that has changed
recently? I have not specified this before. However, may be I was just
getting lucky!

Cheers
Jon
