From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [PATCH/RFC] ARM: OMAP: unlock flash device during boot
Date: Thu, 18 Oct 2007 20:23:58 -0500
Message-ID: <4718072E.7020104@gmail.com>
References: <20071017222526.493688502@mvista.com>	<3B6D69C3A9EBCA4BA5DA60D9130274290242BDAC@dlee13.ent.ti.com>
	<47176E1C.3060009@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <47176E1C.3060009@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Kevin Hilman stated on 10/18/2007 9:30 AM:
> Woodruff, Richard wrote:
>> Long ago when the part size changed one version of the omap-nor driver did need to unlock partitions.  This was done on some internal tree version.
>>
>> By partitions I mean physical ones, inside the NOR part.  Not mtd_partitions().  This only needed to be done on a per-partition basis not a per-sector one.
>>
>> These physical partitions, allow for simultaneous XIP and programming on the same NOR chip.  One partition can be in status mode while another has code executing out of it.  
>>
>> It kind of looks like this patch was aiming to do this.
> 
> FWIW, this patch was taken from the TI kernels on linux.omap.com which
> have the same call to unlock in the probe hook.
> 
I recollect some time back we had a similar discussion on a possibility of:
a) partition 1 (boot readonly partition) having a basic filesystem which
would unlock partition 2
b) partition 2: read/write which would contain all the stuff that
filesystem would like to move around.

This would allow for map drivers to do nothing special on bootup.

Regards,
Nishanth Menon
