From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: Plea for MMC spec owners
Date: Mon, 05 Jun 2006 17:57:25 +0200
Message-ID: <44845465.9020505@drzeus.cx>
References: <77C7F7CB1230A74A9D19C0C111E6EDBE41C7BA@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <77C7F7CB1230A74A9D19C0C111E6EDBE41C7BA@DLEE09.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Khasim, Syed" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Khasim, Syed wrote:
> Hi Pierre,
>
> A quick search to write_bl_partial and read_bl_partial in MMC spec gave
> the following lines.
>   

Thanks. Unfortunately, it wasn't the response I was hoping for as it
isn't consistent with what we've been seeing with other MMC and SD readers.

> I think you already have this pointer to SD spec, might be helpful to
> others.
>
> http://www.sdcard.org/sd_memorycard/Simplified%20Physical%20Layer%20Spec
> ification.PDF
>
>   

I have to admit, I hadn't looked that closely at that spec as it didn't
cover the protocol properly. But it actually said something about this
issue:

4.3.2 2GByte Card
To make 2GByte card, the Maximum Block Length (READ_BL_LEN=WRITE_BL_LEN)
shall be set to
1024 bytes. But Block Length set by CMD16 shall be up to 512 bytes to
keep consistency with 512
bytes Maximum Block Length cards (Less than and equal 2GByte cards).

Could you have a second look in the MMC spec and see if there are
similar provisions?

Rgds
Pierre
