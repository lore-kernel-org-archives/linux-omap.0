From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH TRY2] WATCHDOG: use base address from platform resources
	and make 2430 boot again
Date: Thu, 26 Apr 2007 18:09:49 +0000
Message-ID: <20070426180949.GG9764@atomide.com>
References: <782515bb0704041855x4ff69d3bp19d386805eaecf16@mail.gmail.com>
	<5d5443650704050320t242adc8ak46c76cfbc69449ed@mail.gmail.com>
	<4614EF05.6050606@gmail.com>
	<5d5443650704050642n2fcebf7dg34b5e94be428de96@mail.gmail.com>
	<46153174.8040706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <46153174.8040706@gmail.com>
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

* Nishanth Menon <menon.nishanth@gmail.com> [070405 17:27]:

> WATCHDOG: use base address from platform resources and make 2430 boot again
> Modfied watchdog driver to use base address provided in platform defn
> Cleaned up a bunch of statics used.
> Added 2430 baseaddress defn
> Addressed review comments for patch1 and 2 reported by Trilok Soni and Tony

Pushing today, I've split out the devices.c part into a separate patch.

Tony
