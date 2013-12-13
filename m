From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 1/7] usb: dwc3: keystone: add basic PM support
Date: Fri, 13 Dec 2013 18:15:15 -0500
Message-ID: <52AB9503.2090801@ti.com>
References: <20131212214306.GS1939@saruman.home>
 <1386884755-12366-1-git-send-email-balbi@ti.com> <52AA54E4.5000606@ti.com>
 <20131213004337.GA31622@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131213004337.GA31622@saruman.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com
Cc: kgene.kim@samsung.com, w-kwok2@ti.com, Linux USB Mailing List <linux-usb@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thursday 12 December 2013 07:43 PM, Felipe Balbi wrote:
> On Thu, Dec 12, 2013 at 07:29:24PM -0500, Santosh Shilimkar wrote:
>> On Thursday 12 December 2013 04:45 PM, Felipe Balbi wrote:
>>> A bare-minimum PM implementation which will
>>> server as building block for more complex
>> s/server/serve ;-)
> 
> hah! :-) will fix in my branch.
> 
>>> PM implementation in the future.
>>>
>>> At the least will not leave clocks on unnecessarily
>>> when e.g.  a user write mem to /sys/power/state.
>>>
>>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>>> ---
>>>
>>> improve error path a little bit.
>>>
>> We will test this out. Thanks for the
>> patch Felipe.
> 
I see Wingman already tested the patch.
Feel free add, my ack if you need one...

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
