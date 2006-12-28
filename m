From: "Komal Shah" <komal.shah802003@gmail.com>
Subject: Re: [PATCH]: Workqueue changes for board-h3
Date: Thu, 28 Dec 2006 20:18:44 +0530
Message-ID: <3a5b1be00612280648v40a7b92eq35189cd68bc1bc9@mail.gmail.com>
References: <20061228132843.6403.qmail@web33710.mail.mud.yahoo.com>
	<25c21ceb0612280531u2c01acfase9a95e81e6d37cfe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <25c21ceb0612280531u2c01acfase9a95e81e6d37cfe@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: =?ISO-8859-1?Q?Ragner_N_Magalh=E3es?= <ragner@users.sourceforge.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 12/28/06, Ragner N Magalh=E3es <ragner@users.sourceforge.net> wrote:
> ---------- Forwarded message ----------
> From: Felipe Balbi <felipe.lima@indt.org.br>
> Date: Dec 28, 2006 9:28 AM
> Subject: [PATCH]: Workqueue changes for board-h3
> To: ragner.magalhaes@gmail.com
>
> Hello all,
>
>
> This patch fixes an error regarding workqueue changes on board-h3 file.]
>
>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D CUT HERE =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Fixes a compile issue when using CONFIG_MACH_OMAP_H3 regarding workqueues=
.
>
> Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
> ---
>
> Index: linux-omap-2.6-dev/arch/arm/mach-omap1/board-h3.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-omap-2.6-dev.orig/arch/arm/mach-omap1/board-h3.c
> +++ linux-omap-2.6-dev/arch/arm/mach-omap1/board-h3.c
> @@ -298,5 +298,5 @@ static int h3_select_irda(struct device
>
> -static void set_trans_mode(void *data)
> +static void set_trans_mode(struct work_struct *data)
>  {
> -       int *mode =3D data;
> +       int *mode =3D (int *)data;

Did you tested this patch.? I am not sure this casting is the correct
way to go for it.


--=20
---Komal Shah
http://komalshah.blogspot.com
