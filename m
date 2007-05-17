From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH 0/5] Clean up omap24xx.h symbolic constants
Date: Thu, 17 May 2007 14:11:06 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47F15B8E@dlee13.ent.ti.com>
References: <20070517181423.GD8556@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070517181423.GD8556@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


>Maybe just use OMAP2_ prefix for defines common to all omaps >=3D 2
>until we have have to rename some registers again?
>
>Anybody have better ideas?
>

I agree with this approach, as most of the peripherals have same =
register offset and bit definitions.

Regards,
Khasim
