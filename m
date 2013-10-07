From: Joel Fernandes <joelf@ti.com>
Subject: Re: [RFC] ARM: kernel: irq: Simplify allocation of stack frame
Date: Mon, 7 Oct 2013 11:28:03 -0500
Message-ID: <5252E113.3080301@ti.com>
References: <1381098649-21417-1-git-send-email-joelf@ti.com>
 <20131006224150.GA25647@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131006224150.GA25647@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: =?ISO-8859-1?Q?Andr=E9_Hent?= =?ISO-8859-1?Q?schel?= <nerv@dawncrow.de>, Jonathan Austin <jonathan.austin@arm.com>, Nicolas Pitre <nico@linaro.org>, linux-kernel@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 10/06/2013 05:41 PM, Russell King - ARM Linux wrote:
> On Sun, Oct 06, 2013 at 05:30:47PM -0500, Joel Fernandes wrote:
>> On receiving IRQ exception in SVC mode, all the SVC mode registers are saved
>> onto the stack very early on.
>>
>> The stack frame allocation code for IRQ entry during SVC mode (svc_entry) is
>> hard to read as 4-less is allocated initially only to be allocated later
>> implicity using the mov r3, [sp, #-4]! instruction. We make code easier to read
>> by allocating the 4 bytes on the stack frame in the beginning itself and remove
>> all instances where 4 bytes is adjusted.
> 
> You omit to say that this results in saving one additional register
> unnecessarily in the stmia.  We could use a stmib there instead which
> would avoid that issue while keeping the rest of the change.
> 

Hi Russel,

BTW I used ETM to check the number of cycles used to store the extra register
with and without this patch and with both cases it takes 7 cycles.

My platform uses Cortex-A8 (AM335x SoC).

Thanks,

-Joel
