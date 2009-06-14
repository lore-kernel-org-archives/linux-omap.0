From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH (V2)] TVP514x: Migration to sub-device framework
Date: Sun, 14 Jun 2009 12:50:04 -0700
Message-ID: <200906141250.04455.david-b@pacbell.net>
References: <hvaibhav@ti.com>
	<1241634693-28208-1-git-send-email-hvaibhav@ti.com>
	<200906141214.38355.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <200906141214.38355.hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sunday 14 June 2009, Hans Verkuil wrote:
> > +#define dump_reg(sd, reg, val)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0\
> > =A0=A0=A0=A0=A0=A0do {=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0\
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0val =3D tvp514x_read_reg(clie=
nt, reg);=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0\
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0v4l_info(client, "Reg(0x%.2X)=
: 0x%.2X\n", reg, val); \
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0val =3D tvp514x_read_reg(sd, =
reg);=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0\
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0v4l2_info(sd, "Reg(0x%.2X): 0=
x%.2X\n", reg, val); \
> > =A0=A0=A0=A0=A0=A0} while (0)
>=20
> Why not turn this into a static inline function? Much better than a mac=
ro.

IMO, too big for either.  Make it a real function.
