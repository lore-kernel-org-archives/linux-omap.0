From: Drew Moseley <dmoseley@mvista.com>
Subject: Re: Need to call kgdb8250_add_platform_port in omap_serial_init()?
Date: Fri, 12 Oct 2007 13:58:06 -0700
Message-ID: <470FDFDE.4070800@mvista.com>
References: <470E63B4.40103@mvista.com> <20071012203107.GJ7979@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071012203107.GJ7979@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Tony Lindgren wrote:
> Hi,
> 
> * Drew Moseley <dmoseley@mvista.com> [071011 10:57]:
>> The patch below calls kgdb8250_add_platform_port() from omap_serial_init().
>> This is copied from mach-omap/serial.c.  Without this patch kgdbwait
>> will fail.
>>
>> Comments?
> 
> Makes sense, but I can't find any references in linux-omap for
> kgdb8250_add_platform_port... I guess that's in some other tree?
> 
> Regards,
> 
> Tony
> 

Indeed.  Sorry about that.  Resubmitted to the kgdb bugreport list.

Drew
