From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] of: Add a reg-names property to name reg entries
Date: Tue, 25 Oct 2011 12:29:45 +0200
Message-ID: <440786C5-FA1C-4750-9990-0BA5AABC2190@kernel.crashing.org>
References: <1319471697-8970-1-git-send-email-b-cousson@ti.com>
	<20111025082632.GJ4429@atomide.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20111025082632.GJ4429@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, rob.herring@calxeda.com, Benoit Cousson <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

>> +		compatible = "ti,mcasp";
>> +		reg = <0 0x10 0x10>, <0 0x20 0x10>,
>> +		      <1 0x10 0x10>, <1 0x20 0x10>;
>> +		reg-names = "mpu", "dat",
>> +			    "dma", "dma_dat";
>
> Hmm for some systems looks like this can also solve how to pass the
> mux signal names cleanly from DT.

What problem does any of this solve?  The device binding for the
"mcasp" device will have to describe the possible "reg-names", and
what those mean; but the binding already has to describe its "reg"
property anyway.

The example looks like something that should be more properly done
with subdevices, not sure.


Segher
