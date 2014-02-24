From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCHv4 0/7] omap hwspinlock dt support
Date: Mon, 24 Feb 2014 12:14:24 -0600
Message-ID: <530B8C00.8020001@ti.com>
References: <1389658764-39199-1-git-send-email-s-anna@ti.com>
 <52F9282B.5000702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <52F9282B.5000702@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Mark, Ohad,

On 02/10/2014 01:27 PM, Suman Anna wrote:
> Mark,
>
> On 01/13/2014 06:19 PM, Suman Anna wrote:
>> Hi,
>>
>> This is an updated series mainly addressing Mark Rutland's comments
>> about hwlock specifier being always one-cell. The series adds the
>> support for #hwlock-cells property and adds a simple default OF
>> translate function.
>>
>> The DTS patches from previous series have already been merged, and
>> needs this property to be added. This is handled in a separate series
>> that only deals with OMAP hwspinlock DTS patches.
>>
>> The series, along with the DTS patches, is tested on top of v3.13-rc8
>> plus Tero's v13 clock DT series and Tony's 3.14 staged branches. The
>> validation on OMAP5, DRA7, AM437 requires Tero's series with couple of
>> additional base patches for AM43xx. AM43xx functionality needs a hwmod
>> fix [1] for creating the associated omap_device as well.
>>
>
> Can you please take a look at this series and give your ack on the
> bindings if you do not have any further comments? The only comments so
> far are from Bjorn on the OF helpers.
>

Gentle reminder, can you provide your acks/comments?

regards
Suman
