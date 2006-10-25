From: Marek =?utf-8?q?Va=C5=A1ut?= <marek.vasut@gmail.com>
Subject: Re: [PATCH 1/4] PalmZ71 - OMAP310 Clocks
Date: Thu, 26 Oct 2006 01:45:26 +0200
Message-ID: <200610260145.26835.marek.vasut@gmail.com>
References: <200610241719.59561.marek.vasut@gmail.com>
	<20061025180733.GJ4852@atomide.com>
	<fb249edb0610251317g49088faelfece9e78c9a4f680@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <fb249edb0610251317g49088faelfece9e78c9a4f680@mail.gmail.com>
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
To: balrogg@gmail.com, linux-omap-open-source@linux.omap.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Dne st=C5=99eda 25 =C5=99=C3=ADjen 2006 22:17 andrzej zaborowski napsal(a):
> Hi,
>
> On 25/10/06, Tony Lindgren <tony@atomide.com> wrote:
> > * Marek Va=C5=A1ut <marek.vasut@gmail.com> [061024 18:22]:
> > > Hi,
> > > this patch enables some clock on omap310.
>
> ...
>
> > Hmm, I thought 310 did not have a DSP? Or is it only 710 that does not
> > have a DSP?
>
> I think the issue here is that some of McBSPs depend on the DSP clocks
> (or rather on the corresponding bits being set in "clock & reset"
> module). I don't know if this is a hardware dependency or Linux clock
> framework dependency, but I wouldn't be surprised if it's hardware.

Yup, that=C2=B4s right. Without these changes the soundchip (aic23) wont wo=
rk (it=C2=B4s=20
connected over mcbsp). It=C2=B4s MCBSP dependency as balrog said.
