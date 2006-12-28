From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] ARM: OMAP: ISP1301 workqueue fixes
Date: Thu, 28 Dec 2006 12:05:37 -0800
Message-ID: <200612281205.37642.david-b@pacbell.net>
References: <45937A00.1070803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <45937A00.1070803@gmail.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Thursday 28 December 2006 12:02 am, Dirk Behme wrote:
> =A0static void
> -isp1301_work(void *data)
> +isp1301_work(struct work_struct *data)
> =A0{
> -=A0=A0=A0=A0=A0=A0=A0struct isp1301=A0=A0*isp =3D data;
> +=A0=A0=A0=A0=A0=A0=A0struct isp1301=A0=A0*isp =3D (struct isp1301 *)da=
ta;
> =A0=A0=A0=A0=A0=A0=A0=A0int=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0stop;

Clearly incorrect.  It should use container_of().  The work_struct
is NOT the first member of that struct... this will be oopsing.
