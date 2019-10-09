From: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Subject: Re: [PATCHv8 1/9] dt-bindings: omap: add new binding for PRM instances
Date: Wed, 9 Oct 2019 08:59:43 -0700
Message-ID: <dc2a9659-8593-e5d0-54b2-44d827e76759@oracle.com>
References: <20191008125544.20679-1-t-kristo@ti.com>
 <20191008125544.20679-2-t-kristo@ti.com>
 <20191008154655.u34wkbqgmelv3aea@earth.universe>
 <115ab938-e025-98fa-3b9e-0b3ced39307d@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <115ab938-e025-98fa-3b9e-0b3ced39307d@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>, Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, tony@atomide.com, p.zabel@pengutronix.de, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 10/8/19 11:52 PM, Tero Kristo wrote:
> On 08/10/2019 18:46, Sebastian Reichel wrote:
>> Hi,
>>
>> On Tue, Oct 08, 2019 at 03:55:36PM +0300, Tero Kristo wrote:
>>> +Example:
>>> +
>>> +prm_dsp2: prm@1b00 {
>>> +=A0=A0=A0 compatible =3D "ti,omap-prm-inst", "ti,dra7-prm-inst";
>>
>> Nit: compatible values are sorted the other way around (most
>> specific first).
> =

> Hmm right, I would not like to re-post the whole series just for this =

> seeing all the acks are in place already.
> =

> Santosh, do you want to fix this locally or shall we post a separate =

> patch later on to fix this?
> =

No need. I fixed it up. Pls check.

git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git =

for_5.5/driver-soc

Regards,
Santosh
