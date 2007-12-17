From: "Shobhit Kumar" <shos.arora@gmail.com>
Subject: Re: ALSA driver for audio codec on TWL4030
Date: Mon, 17 Dec 2007 10:07:53 +0530
Message-ID: <376191c90712162037j2c3a21fbp3656a3d6cc42ece3@mail.gmail.com>
References: <376191c90712131052p359b9927ic31671ed8b4de0f8@mail.gmail.com>
	<7EAD1AEEA7621C45899FE99123E124A001453D3B@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <7EAD1AEEA7621C45899FE99123E124A001453D3B@dbde01.ent.ti.com>
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
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

>
>
> > that the ALSA driver for audio codec on TWL4030 is not included. I
> checked
> > the 2.6.14 release from TI which has the driver for the same. But this
> > same
> > driver cannot probably used as is on 2.6.21 kernel due to various ALSA
> > framework changes.
> >
> > Is there a port available on 2.6.21 kernel or would I have to port it..
> >
>
> We have uploaded new source for 3430 on linux.omap.com, it is 2.6.22based. This should also be working for 2430. I think you can use the ALSA
> framework here for 2430 or switch your complete work to 2.6.22.
>

Thanks a lot. I would try this driver on 2430 and post the results here.


-- 
Rgds
Shobhit
