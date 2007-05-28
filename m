From: "=?ISO-8859-1?Q?Ragner_N_Magalh=E3es?=" <ragner@users.sourceforge.net>
Subject: Re: Removing Gadget File Storage module
Date: Mon, 28 May 2007 14:39:37 -0400
Message-ID: <25c21ceb0705281139o21ba11f7ub3ebec55044cefbc@mail.gmail.com>
References: <25c21ceb0705280932l32668663y6396faabec70c2ab@mail.gmail.com>
	<855a48e20705281019l53b48b2r2bbdc4dfc674f6f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <855a48e20705281019l53b48b2r2bbdc4dfc674f6f5@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: =?ISO-8859-1?Q?Jos=E9_Lu=EDs?= <jluisn@gmail.com>
Cc: linux-omap-open-source@linux.omap.com, linux-usb-devel@lists.sourceforge.net
List-Id: linux-omap@vger.kernel.org

Hi,

On 5/28/07, Jos=E9 Lu=EDs <jluisn@gmail.com> wrote:
> Hi Ragner,
>
> Try unmount the /media/mmc* volumes before remove the module.
> []'s

I am not mounting /media/mmc*

I think that is some thing with signal arrives at
sleep_thread(struct fsg_dev *fsg) function ...
called by fsg_main_thread(void *fsg_) ...


> Jos=E9 Lu=EDs
>
> --
> Jos=E9 Lu=EDs do Nascimento
> Mestrando em Engenharia El=E9trica
> Laborat=F3rio de Sistemas Embarcados e Computa=E7=E3o Pervasiva
> Centro de Engenharia El=E9trica e Inform=E1tica - CEEI
> Universidade Federal de Campina Grande - UFCG
> jluisn@dee.ufcg.edu.br

Thanks,

-- =

Ragner N Magalh=E3es

Instituto Nokia de Tecnologia - INdT
Open Source Mobile Research Center - OSMRC
Linux Kernel Team

E-mail: ragner.magalhaes@indt.org.br
            ragner@users.sourceforge.net

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
