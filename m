From: "nishanth menon" <menon.nishanth@gmail.com>
Subject: Re: [PATCH] mkuboot.sh: quit elegantly on not finding mkimage
Date: Wed, 16 May 2007 18:07:43 -0500
Message-ID: <782515bb0705161607s3d893efdm93bc4c5200b48bb2@mail.gmail.com>
References: <782515bb0705081717jaea0fdbj3b4cbd3325fcbbe3@mail.gmail.com>
	<20070516151838.GC20297@atomide.com>
	<E7B2429D-CC5F-4B4B-9436-03DE1DF0CF6E@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <E7B2429D-CC5F-4B4B-9436-03DE1DF0CF6E@mvista.com>
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
To: "George G. Davis" <gdavis@mvista.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On 5/16/07, George G. Davis <gdavis@mvista.com> wrote:
> I submitted a fix for this to LKML long ago and the PPC folks shot it
> down
> because they want silent failure for the case where mkimage is not
> found.
Thanks George. Got the thread:
http://lkml.org/lkml/2005/3/13/33

And the counter argument here:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0503.1/1002.html

Regards,
Nishanth Menon
