From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 2/2] ARM: dts: AM4372: add few nodes
Date: Fri, 16 Aug 2013 17:11:27 -0600
Message-ID: <520EB19F.1010005@wwwdotorg.org>
References: <ffa2f76fcac54bfe76c234ffce0394fd2c25fe52.1375450395.git.afzal@ti.com>
 <6f0f838176ab93aac8dab4c3ab9d9f95a3027ff7.1375450395.git.afzal@ti.com>
 <51FCEE60.7080809@ti.com> <51FF335D.4050803@ti.com>
 <20130810142317.GE18085@e106331-lin.cambridge.arm.com>
 <52088526.90004@ti.com> <520DFC37.3080601@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <520DFC37.3080601@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Mugunthan V N <mugunthanvnm@ti.com>, Afzal Mohammed <afzal@ti.com>, Russell King <linux@arm.linux.org.uk>, Ian Campbell <ian.campbell@citrix.com>, Pawel Moll <Pawel.Moll@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 08/16/2013 04:17 AM, Benoit Cousson wrote:
> Hi Afzal,
> 
> On 12/08/2013 08:48, Afzal Mohammed wrote:
>> Hi Mark,
>>
>> On Saturday 10 August 2013 07:53 PM, Mark Rutland wrote:
>>
>>>>>> +        mac: ethernet@4a100000 {
>>>>>> +            compatible = "ti,am4372-cpsw","ti,cpsw";
>>
>>> One point worth mentioning is that the "ti,am4372-cpsw" string isn't
>>> documented. Will the "ti,am4372-cpsw" binding definitely be a superset
>>> of the "ti,cpsw" binding, and if you were to take the DT as of this
>>> patch, and attempt to use it with a future kernel, can you guarantee
>>> it'll work?
>>
>> "ti,am4372-cpsw" was not documented as OMAP DT maintainer didn't prefer
>> documenting only for a new compatible.
> 
> My point was more that creating a new compatible for the exact same
> version of the IP is pointeless and could lead to tons of compatible
> strings that would never be used since this is always the exact same IP.

Well, there are two aspects: Version of the IP block, and the
integration into the SoC. We need an entry in compatible for any/all of
these. If the IP block doesn't have some standalone versioning scheme
because the design flow isn't IP-block-centric, the SoC name makes a
reasonable substitute.

...
> My second point is, even if we want to differentiate the IPs in various
> SoCs, using the name of the SoC in the IP compatible string is not a
> very good practice anyway.

There may be integration-specific issues, so even if SoC A and B use the
exact same IP block version, there should still be compatible values for
the SoC as well as the IP block version, so you can quirk on those later.

... although I suppose it might not be too bad if the IP block
compatible value only contained the IP block version, and if any
integration-specific quirks were needed, they could be triggered off
entries in the top-level node's compatible value? That only works for
on-Soc modules, and not complex MFD-like modules, unless you have an
easy way to find the DT node for the top-level of the MFD...
