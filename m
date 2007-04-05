From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] WATCHDOG: use base address from platform resources and
	make 2430 boot again
Date: Thu, 5 Apr 2007 09:30:57 -0400
Message-ID: <20070405133055.GD24297@atomide.com>
References: <782515bb0704041855x4ff69d3bp19d386805eaecf16@mail.gmail.com>
	<5d5443650704050320t242adc8ak46c76cfbc69449ed@mail.gmail.com>
	<4614EF05.6050606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <4614EF05.6050606@gmail.com>
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

* Nishanth Menon <menon.nishanth@gmail.com> [070405 08:44]:
> Hi Trilok,
> Thanks for your time in helping review the patch. :)
> 
> Trilok Soni stated on 4/5/2007 5:20 AM:
> >
> > Changelog goes in the SCM metadata, not source files. Please avoid this.
> Is this a new convention? No offence intended, but I like my signature
> on the files I touch extensively.. since it is not denied by
> coding_standards.txt, kinda pulling on leeway here.. :)

The problem with this is that we will always get nailed on that
trying to send the patches upstream, see current omap update on LKML
right now for example. So we should generate patches that do not
leave any reason for anybody to complain.

Regards,

Tony
