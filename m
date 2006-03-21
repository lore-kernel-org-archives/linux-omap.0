From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] snapshot boot on omap osk 5912
Date: Tue, 21 Mar 2006 05:51:50 -0800
Message-ID: <20060321135148.GB16337@atomide.com>
References: <20060308.214946.48536311.kaminaga@sm.sony.co.jp>
	<20060320152105.GE4980@atomide.com>
	<20060321.124548.41636126.kaminaga@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060321.124548.41636126.kaminaga@sm.sony.co.jp>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Hiroki Kaminaga <kaminaga@sm.sony.co.jp> [060320 19:47]:
> > > On target osk5912, software-suspend (suspend-to-disk) is now working,
> > > and resume-from-disk takes about 10sec. This is on linux-2.6.11 + omap
> > > patch + software-suspend arm porting.
> > 
> > Cool. Do you have a url for the software-suspend arm porting patch +
> > your patches?
> 
> Yes,
> 
> I posted an arm portin patch at
> http://lists.osdl.org/pipermail/linux-pm/2005-July/001077.html
> The problem here turned out to be flash read/write timing error, and
> above patch would work.
> 
> It's root=/dev/nfs, and suspend image to /dev/mtdblock3 (which is flash)

Thanks, so it's the same patch. But I think the mailing list ate your
"above patch again"...

Tony
