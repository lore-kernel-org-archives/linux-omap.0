From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: OMAP baseline test results for v3.8-rc6
Date: Fri, 8 Feb 2013 14:02:54 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EC06EB2@DBDE01.ent.ti.com>
References: <alpine.DEB.2.00.1302062333270.12769@utopia.booyaka.com>
 <20130207083217.GA15462@arwen.pp.htv.fi>
 <79CD15C6BA57404B839C016229A409A83EC06CEA@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1302081306230.11464@utopia.booyaka.com>
 <87ehgqlxca.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87ehgqlxca.fsf@dell.be.48ers.dk>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Korsgaard <jacmet@sunsite.dk>, Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 08, 2013 at 19:30:21, Peter Korsgaard wrote:
> >>>>> "Paul" == Paul Walmsley <paul@pwsan.com> writes:
> 
> Hi,
> 
>  Paul> So what I'd like to know is why it doesn't work with >= v3.8-rc1
>  Paul> with an appended DTB:
> 
>  Paul> http://www.pwsan.com/omap/testlogs/test_v3.8-rc1/20121228031713/boot/am335xbone/am335xbone_log.txt
> 
>  Paul> The point is to try to minimize bootloader dependencies.
> 
>  Paul> Haven't had the chance to try Felipe's suggestion yet re fdt_high.
> 
> That shouldn't matter when using appended dtb.
> 

That's correct, relocating dtb should not matter for appended DTB kernel 
image.

I am trying now with appended DTB, 

Thanks,
Vaibhav
