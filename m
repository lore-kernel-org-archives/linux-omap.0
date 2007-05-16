From: "George G. Davis" <gdavis@mvista.com>
Subject: Re: [PATCH] mkuboot.sh: quit elegantly on not finding mkimage
Date: Wed, 16 May 2007 08:56:35 -0700
Message-ID: <E7B2429D-CC5F-4B4B-9436-03DE1DF0CF6E@mvista.com>
References: <782515bb0705081717jaea0fdbj3b4cbd3325fcbbe3@mail.gmail.com>
	<20070516151838.GC20297@atomide.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070516151838.GC20297@atomide.com>
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
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org


On May 16, 2007, at 8:18 AM, tony@atomide.com wrote:

> * nishanth menon <menon.nishanth@gmail.com> [070508 17:18]:
>> Hi All,
>> A tiny patch: when mkimage is not found return 1 instead of 0. helps
>> to ensure that the make uImage fails if mkimage is not in path.

I submitted a fix for this to LKML long ago and the PPC folks shot it  
down
because they want silent failure for the case where mkimage is not  
found.

--
Regards,
George

>>
>> Could not find a vgers list for scripts.. hence posting here..
>
> You should post this to LKML as u-boot is cross platform. Or send it
> to the u-boot maintainer to send it to LKML.
>
> Tony
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
