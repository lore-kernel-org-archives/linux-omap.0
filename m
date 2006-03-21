From: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Subject: Re: [RFC] snapshot boot on omap osk 5912
Date: Tue, 21 Mar 2006 12:45:48 +0900 (JST)
Message-ID: <20060321.124548.41636126.kaminaga@sm.sony.co.jp>
References: <20060308.214946.48536311.kaminaga@sm.sony.co.jp>
	<20060320152105.GE4980@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060320152105.GE4980@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: tony@atomide.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> > On target osk5912, software-suspend (suspend-to-disk) is now working,
> > and resume-from-disk takes about 10sec. This is on linux-2.6.11 + omap
> > patch + software-suspend arm porting.
> 
> Cool. Do you have a url for the software-suspend arm porting patch +
> your patches?

Yes,

I posted an arm portin patch at
http://lists.osdl.org/pipermail/linux-pm/2005-July/001077.html
The problem here turned out to be flash read/write timing error, and
above patch would work.

It's root=/dev/nfs, and suspend image to /dev/mtdblock3 (which is flash)


(Hiroki Kaminaga)
t
--
