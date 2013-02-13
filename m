From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Use of of_parse_phandle()/of_node_put()
Date: Wed, 13 Feb 2013 16:52:34 +0100
Message-ID: <511BB6C2.3060105@ti.com>
References: <F3DBB1B3EF102E4994C89758CFCA32412C6E52@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <F3DBB1B3EF102E4994C89758CFCA32412C6E52@DBDE01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Kumar, Anil" <anilkumar.v@ti.com>
Cc: Alsa Devel List <alsa-devel@alsa-project.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "jarkko.nikula@bitmer.com" <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

On 02/13/2013 07:04 AM, Kumar, Anil wrote:
> Hi  Peter,
>  =

> Just trying to understand.
>  =

> In omap-twl4030.c file probe function :-
>  =

> dai_node =3D of_parse_phandle(node, "ti,mcbsp", 0);
>                 if (!dai_node) {
>                         dev_err(&pdev->dev, "McBSP node is not provided\n=
");
>                         return -EINVAL;
>                 }
>  =

> Here  =93of_parse_phandle()=94  is used to get  =93of_device=94 node poin=
ter.
> of_parse_phandle() suggest to use of_node_put()  on it when done.
>  =

> It looks when code request for an =93of_device=94 node, kernel  maintains
> =93refcount=94 for this.
> It check =93refcount=94  before giving pointer of of_device node and  WAR=
N_ON()
> in case of refcount  > 0 and increase it on success.
>  =

> Should this code need to use of_node_put() on the requested =93of_device=
=94 when done
> so that this can be get  again ?

Hrm, one thing or sure we should not call it of_node_put() while we have the
card loaded since the node is used runtime by the core.

However when we unload the machine driver it might be needed, but not sure
about this. None of the existing machine drivers doing it (tegra, samsung,
omap, etc).
But if it is needed it might be better to be done by the core?

>  =

> I am taking reference of Linux-next kernel.
>  =

> I'm sorry if this question is very vague or  missing something.
>  =

> Thanks,
> Anil
>  =

>  =

>  =

>  =

>  =

>  =



-- =

P=E9ter
