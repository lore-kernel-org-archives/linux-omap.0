From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: Fwd: [RFC/PATCH v2 09/13] dt: omap4: add soc file for handling
	i2c controllers
Date: Tue, 23 Aug 2011 21:45:09 +0200
Message-ID: <4E540345.1090004@ti.com>
References: <1314074021-25186-10-git-send-email-manjugk@ti.com>
	<4E537FA7.3050609@ti.com> <4E53AF9F.8070607@ti.com>
	<20110823151841.GB32698@manju-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110823151841.GB32698@manju-desktop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 8/23/2011 5:18 PM, G, Manjunath Kondaiah wrote:
> On Tue, Aug 23, 2011 at 03:48:15PM +0200, Cousson, Benoit wrote:
>> From: G, Manjunath Kondaiah<manjugk@ti.com>
>>> To: devicetree-discuss@lists.ozlabs.org
>>> CC: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
>>>
>>>
>>> Add omap4 soc dts file for handling omap4 soc i2c
>>> controllers existing on l4-core bus.
>>
>> The subject and changelog is not accurate. You are doing at least 3 things:
>> Moving the OMAP4 SoC data from panda board file to a SoC specific
>> omap4.dtsi file.
>> Including the omap4.dtsi into panda.
>> Adding some i2c nodes.
>>
>> You should use at least two or three separated patches to avoid
>> in-accurate subject.
>
> As these changes are straight forward, I can update patch description with
> the required information instead of create too many patches.
>
> If you are too specific on splitting the patches, I am ok with that too.

I already fixed partially the OMAP4 patches as part of my upcoming OMAP4 
early devices DT migration. So I'll rebase your series on top of it.

I'll send you that tomorrow.

Benoit
