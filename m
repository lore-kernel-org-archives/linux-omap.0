From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] ARM: OMAP: omapfb: screen base should be set for
 allocated regions [was Re: Framebuffer driver broken on OSK]
Date: Wed, 05 Jul 2006 17:52:20 +0200
Message-ID: <44ABE034.9060503@gmail.com>
References: <44AA8391.7010708@gmail.com> <20060705153724.GA32164@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060705153724.GA32164@localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: imre.deak@solidboot.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

imre.deak@solidboot.com wrote:
> Hi Dirk,
> 
> On Tue, Jul 04, 2006 at 05:04:49PM +0200, Dirk Behme wrote:
> 
>>Hi,
>>
>>seems that framebuffer on OSK from recent git has some more 
>>trouble (not only the missing parameter from my last mail):
>>
>>It crashes completely on OSK. Backlight of LCD is enabled, 
>>but then: See log below (low level debugging enabled, 
>>without no messages).
>>
>>Any ideas?
> 
> 
> Yes, I forgot to test the fbconsole on OMAP1, now I bumped into this on
> 1510 as well. Your's is probably the same bug:

Yes, looks okay.

Thanks

Dirk
