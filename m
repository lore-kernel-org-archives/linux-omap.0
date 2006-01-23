From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] keypad refresh2
Date: Mon, 23 Jan 2006 06:43:19 -0800 (PST)
Message-ID: <20060123144319.89522.qmail@web32910.mail.mud.yahoo.com>
References: <20060122221251.GA1068@two.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060122221251.GA1068@two.research.nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Juha Yrj=F6l=E4 <juha.yrjola@nokia.com> wrote:

> On Tue, Jan 17, 2006 at 09:43:16AM -0800, ext Komal Shah wrote:
>=20
> > +	if (cpu_is_omap24xx() && omap_has_menelaus()) {
> > +		row_gpios[5] =3D 0;
> > +		col_gpios[2] =3D 15;
> > +		col_gpios[6] =3D 18;
> > +	}
>=20
> What's this about?  What does the keypad have to do with Menelaus?

The first H4 board came out from TI was not having Menelaus chip. And
gpio signals were changed in the H4 EVM came out with Menelaus for
keypad. So only way to differentiate between the two was Menelaus chip
on the new board.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20
