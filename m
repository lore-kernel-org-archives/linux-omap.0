From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH] WATCHDOG: use base address from platform resources and
	make 2430 boot again
Date: Thu, 5 Apr 2007 18:30:10 +0530
Message-ID: <5d5443650704050600l3e22d05dl761fce5e5ee2f653@mail.gmail.com>
References: <782515bb0704041855x4ff69d3bp19d386805eaecf16@mail.gmail.com>
	<5d5443650704050320t242adc8ak46c76cfbc69449ed@mail.gmail.com>
	<4614EF05.6050606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4614EF05.6050606@gmail.com>
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
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 4/5/07, Nishanth Menon <menon.nishanth@gmail.com> wrote:
> Hi Trilok,
> Thanks for your time in helping review the patch. :)
>
> Trilok Soni stated on 4/5/2007 5:20 AM:
> > Few comments:
> >
> > + *                             statics
> >  */
> >
> > Changelog goes in the SCM metadata, not source files. Please avoid this.
> Is this a new convention? No offence intended, but I like my signature
> on the files I touch extensively.. since it is not denied by
> coding_standards.txt, kinda pulling on leeway here.. :)
> >
> > -static void omap_wdt_ping(void)
> > +static void omap_wdt_ping(struct omap_wdt_dev *wdev)
> > {
> > +    void __iomem    *base=wdev->base;
> >
> >
> > space between *base and wdev->base is required for readability.
> yup.. typie typie....
> > +    wdev = (struct omap_wdt_dev *) platform_get_drvdata(omap_wdt_dev);
> >
> > You don't need casting here, I think.
> cleaner.. since get_drvdata returns void *.. makes sense to explain what
> form i am casting to-helps novice readers of code.. readability..

But the compiler is intelligent. So, I don't think this unnecessary
castings is needed at all.

-- 
--Trilok Soni
