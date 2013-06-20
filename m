From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 2/3] mailbox/omap: add support for parsing dt devices
Date: Thu, 20 Jun 2013 17:19:34 -0500
Message-ID: <51C37FF6.5090802@ti.com>
References: <1371594892-37603-1-git-send-email-s-anna@ti.com> <51C37802.2010908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34345 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965316Ab3FTWZ0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Jun 2013 18:25:26 -0400
In-Reply-To: <51C37802.2010908@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.ramirez@copitl.com>, Jassi Brar <jaswinder.singh@linaro.org>, Loic Pallardy <loic.pallardy@st.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Hi Benoit,

On 06/20/2013 04:45 PM, Cousson, Benoit wrote:
> Hi Suman,
> 
> On 6/18/2013 5:34 PM, Suman Anna wrote:
>> Logic has been added to the OMAP2+ mailbox code to
>> parse the mailbox dt nodes and construct the different
>> mailboxes associated with the instance. The design is
>> based on gathering the same information that was being
>> passed previously through the platform data, except for
>> the interrupt type configuration information.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>>   .../devicetree/bindings/mailbox/omap-mailbox.txt   |  46 +++++++
>>   drivers/mailbox/mailbox-omap2.c                    | 141
>> ++++++++++++++++++---
>>   2 files changed, 172 insertions(+), 15 deletions(-)
>>   create mode 100644
>> Documentation/devicetree/bindings/mailbox/omap-mailbox.txt
>>
>> diff --git
>> a/Documentation/devicetree/bindings/mailbox/omap-mailbox.txt
>> b/Documentation/devicetree/bindings/mailbox/omap-mailbox.txt
>> new file mode 100644
>> index 0000000..913bc13
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mailbox/omap-mailbox.txt
>> @@ -0,0 +1,46 @@
>> +OMAP2+ Mailbox Driver
>> +
>> +Required properties:
>> +- compatible:        Should be one of the following,
>> +                "ti,omap2-mailbox" for
>> +                OMAP2420, OMAP2430, OMAP3430, OMAP3630 SoCs
>> +                "ti,omap4-mailbox" for
>> +                OMAP44xx, OMAP54xx, AM33xx, AM43xx, DRA7xx SoCs
>> +- reg:            Contains the mailbox register address range (base
>> address
>> +            and length)
>> +- interrupts:         Contains the interrupt information for the mailbox
>> +            device. The format is dependent on which interrupt
>> +            controller the OMAP device uses
>> +- ti,hwmods:        Name of the hwmod associated with the mailbox
>> +- ti,mbox-num-users:    Number of targets (processor devices) that
>> the mailbox device
>> +            can interrupt
>> +- ti,mbox-num-fifos:    Number of h/w fifos within the mailbox device
>> +- #ti,mbox-data-cells:    Cell size for describing a mailbox
>> +            (currently should be 4)
>> +- ti,mbox-names:    Array of the names of the mailboxes
>> +- ti,mbox-data:        Mailbox descriptor data private to each
>> mailbox. The 4
>> +            cells represent the following data,
>> +              Cell #1 (tx_id) - mailbox fifo id used for
>> +                        transmitting messages
>> +              Cell #2 (rx_id) - mailbox fifo id on which messages
>> +                        are received
>> +              Cell #3 (irq_id) - irq identifier index number to use
>> +                        from the interrupts data
>> +              Cell #4 (usr_id) - mailbox user id for identifying the
>> +                        interrupt into the MPU interrupt
>> +                        controller.
>> +
>> +Example:
>> +
>> +/* OMAP4 */
>> +mailbox: mailbox@4a0f4000 {
>> +    compatible = "ti,omap4-mailbox";
>> +    reg = <0x4a0f4000 0x200>;
>> +    interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
>> +    ti,hwmods = "mailbox";
>> +    ti,mbox-num-users = <3>;
>> +    ti,mbox-num-fifos = <8>;
>> +    #ti,mbox-data-cells = <4>
>> +    ti,mbox-names = "mbox-ipu", "mbox-dsp";
>> +    ti,mbox-data = <0 1 0 0>, <3 2 0 0>;
> 
> That seems to contain a bunch of low level IP internal information.
> Cannot you figure out that from the MAILBOX_REVISION information?

Nope, unfortunately the MAILBOX_REVISION [1] is not enough. It was only
tracking the IP revision, but the number of users and fifos for example
are parameters of the IP, so there are no separate registers from which
this info can be gleaned. I could probably move the ti,mbox-num-users
and ti,mbox-num-fifos into the driver and add it as part of match data
like the intr_type configuration value, but that would mean I would have
to make more compatible strings (possibly one per generation). That
approach however would not scale well for DRA7xx where there is mixture
of different instances with different users and fifos. Since these are
h/w configuration values, I chose to put them in DT.

regards
Suman

[1] http://marc.info/?l=linux-omap&m=137097093615538&w=2

> 
> mbox-names belong here because it does describe the connection outside
> the IP, but I'm not sure all the other data should be there.
> 
> You should put in DT the minimal amount of data that are needed be the
> driver to figure out the rest.
> 
> Please note that I did not check carefully every OMAP specs to see if
> this is possible or not, but most of the time we can reduce the amount
> of information thanks to some HW info already there.
> 
> Regards,
> Benoit
> 


