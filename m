From: David Brownell <david-b@pacbell.net>
Subject: Re: Question About __REG32 marco
Date: Tue, 20 Nov 2007 16:46:42 -0800
Message-ID: <200711201646.42939.david-b@pacbell.net>
References: <005c01c82b61$ac9f1cf0$16110a0a@LongCheer.net>
	<200711201326.06148.david-b@pacbell.net>
	<007d01c82bd7$0e1d8dc0$16110a0a@LongCheer.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <007d01c82bd7$0e1d8dc0$16110a0a@LongCheer.net>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: colorant <colorant@163.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Tuesday 20 November 2007, colorant wrote:
> 	since the index is just 1K, the following definition :
>=20
> typedef struct { volatile u32 offset[4096]; } __regbase32;
>=20
> shouldn't be:
>=20
> =A0typedef struct { volatile u32 offset[1024]; } __regbase32; ?

Would changing that make a difference in the generated code,
or turn up any source code errors?

I'm not sure changing that would matter at all.  And in any
case, those multiboot patches show the downside of this
particular idiom... someone may need to take another look
at the code generation issue, and maybe file some bugs/rfes
against current GCC versions.

- Dave
