From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v7] ARM: dts: omap4-panda: Update the LED support for
 the panda DTS
Date: Fri, 31 May 2013 09:29:42 -0500
Message-ID: <51A8B3D6.1020608@ti.com>
References: <1369826427-31963-1-git-send-email-dmurphy@ti.com>
 <51A8AE72.5010601@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51A8AE72.5010601@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux@arm.linux.org.uk, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi
On 05/31/2013 09:06 AM, Benoit Cousson wrote:
> Hi Dan,
>
> On 05/29/2013 01:20 PM, Dan Murphy wrote:
>> The GPIO for LED D1 on the omap4-panda a1-a3 rev and the omap4-panda-es
>> are different.
>>
>> A1-A3 = gpio_wk7clean
>> ES = gpio_110
>>
>> There is no change to LED D2
>>
>> Abstract away the pinmux and the LED definitions for the two boards into
>> the respective DTS files.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> That patch was good... until Florian introduces some new constant to
> improve the readability of the DTS [1].
>
> Could you rebase on the lastest for_3.11/dts and use the macros for the
> GPIO and pinctrl nodes?
N/P working on it now

Thanks
> Thanks,
> Benoit
>
> [1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg89684.html
>

-- 
------------------
Dan Murphy
