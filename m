From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH v2] misc: sram-exec: Use aligned fncpy instead of memcpy
Date: Thu, 18 May 2017 10:09:41 -0500
Message-ID: <b1edabef-09f3-43e5-3fda-fd87abf16432@ti.com>
References: <20170410145247.6023-1-d-gerlach@ti.com>
 <20170518150134.GA3142@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170518150134.GA3142@kroah.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Keerthy J <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-omap@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 05/18/2017 10:01 AM, Greg Kroah-Hartman wrote:
> On Mon, Apr 10, 2017 at 09:52:47AM -0500, Dave Gerlach wrote:
>> Currently the sram-exec functionality, which allows allocation of
>> executable memory and provides an API to move code to it, is only
>> selected in configs for the ARM architecture. Based on commit
>> 5756e9dd0de6 ("ARM: 6640/1: Thumb-2: Symbol manipulation macros for
>> function body copying") simply copying a C function pointer address
>> using memcpy without consideration of alignment and Thumb is unsafe on
>> ARM platforms.
>>
>> The aforementioned patch introduces the fncpy macro which is a safe way
>> to copy executable code on ARM platforms, so let's make use of that here
>> rather than the unsafe plain memcpy that was previously used by
>> sram_exec_copy. Now sram_exec_copy will move the code to "dst" and
>> return an address that is guaranteed to be safely callable.
>>
>> In the future, architectures hoping to make use of the sram-exec
>> functionality must define an fncpy macro just as ARM has done to
>> guarantee or check for safe copying to executable memory before allowing
>> the arch to select CONFIG_SRAM_EXEC.
>>
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
>> Reviewed-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>> Acked-by: Tony Lindgren <tony@atomide.com>
>
> Can you rebase this and resend as it doesn't apply to the tree right now
> :(
>

Resent as v3 based on v4.12-rc1 and with Acks from v2 added, thanks.

Regards,
Dave

> thanks,
>
> greg k-h
>
