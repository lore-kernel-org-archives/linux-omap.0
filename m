From: Paul Walmsley <paul@booyaka.com>
Subject: RE: [PATCH 0/5] Clean up omap24xx.h symbolic constants
Date: Mon, 21 May 2007 10:52:35 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0705211052010.21469@utopia.booyaka.com>
References: <9C23CDD79DA20A479D4615857B2E2C47F15B8E@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47F15B8E@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Thu, 17 May 2007, Syed Mohammed, Khasim wrote:

>> Maybe just use OMAP2_ prefix for defines common to all omaps >= 2
>> until we have have to rename some registers again?
>>
>> Anybody have better ideas?
>>
>
> I agree with this approach, as most of the peripherals have same register offset and bit definitions.

Makes sense - I will respin the patches with this naming scheme.


- Paul
