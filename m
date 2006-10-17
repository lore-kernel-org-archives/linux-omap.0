From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] USB device support on OMAP2
Date: Tue, 17 Oct 2006 14:15:29 -0700
Message-ID: <200610171415.30093.david-b@pacbell.net>
References: <26510641.122181156424234844.JavaMail.weblogic@ep_ml15>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <26510641.122181156424234844.JavaMail.weblogic@ep_ml15>
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
To: linux-omap-open-source@linux.omap.com, kyungmin.park@samsung.com
List-Id: linux-omap@vger.kernel.org

On Thursday 24 August 2006 5:54 am, =EB=B0=95=EA=B2=BD=EB=AF=BC wrote:

> [PATCH] USB device support on OMAP2
>=20
>   Enable USB device on OMAP2 platform. Only usb0 is used for device wit=
hout DMA.
>   There are remainging issues, DMA and clocks.
>=20
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

I've been looking at this.  What I'll do is split it apart into
smaller chunks and forward them, along with H4 support.  Mostly
it looks OK, except for only including support for the the usb0
port insteaf of also usb1 and usb2 hooks.

- Dave
