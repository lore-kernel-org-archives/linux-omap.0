From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH] OMAP PM interface, version 2
Date: Thu, 19 Jun 2008 09:21:26 +0300
Message-ID: <877icmaqs9.fsf@trdhcp146196.ntc.nokia.com>
References: <20080617145905.20886.89236.stgit@localhost.localdomain>
	<87od5zatew.fsf@trdhcp146196.ntc.nokia.com>
	<alpine.DEB.1.00.0806182334290.24288@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32614 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960AbYFSGYk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Jun 2008 02:24:40 -0400
In-Reply-To: <alpine.DEB.1.00.0806182334290.24288@utopia.booyaka.com> (ext
	Paul Walmsley's message of "Wed, 18 Jun 2008 23:49:03 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@mvista.com

"ext Paul Walmsley" <paul@pwsan.com> writes:

> Hello Jouni,=20
>
> On Wed, 18 Jun 2008, H=C3=B6gander Jouni wrote:
>
>> "ext Paul Walmsley" <paul@pwsan.com> writes:
>>=20
>> > Major changes since the first version:
>> >
>> > 1. Jouni Hogander suggested that the set_max_cpu_lat() function be
>> >    merged into set_max_dev_wakeup_lat(), when set_max_dev_wakeup_l=
at()
>> >    is called with the CPU0 sys_device (via get_cpu_sysdev(0)).  He=
 feels
>> >    that this will be easier for device driver developers to use.  =
This
>> >    change has been made.
>>=20
>> I just noticed that this won't work. We have this declaration:
>>=20
>> (*pdata->set_max_dev_wakeup_lat)(struct device *dev, unsigned long t=
)
>>=20
>> In case of cpu it is not possible to underlying code to identify the
>> caller.=20
>
> Eh, nice catch.  Let's add set_max_intr_lat() back in - perhaps call =
it=20
> set_max_mpu_wakeup_lat() instead for symmetry?

Yes, I agree. Originally my idea to change this was related to that pm
qos extending and actually I didn't expect you to do this change.

>
>> This derives a question should we have parameter for caller
>> identification in set_max_dev_wakeup_lat()?
>>=20
>> I mean currently we are assuming that there is only one caller for e=
ach=20
>> device. Is this correct assumination?  If we think e.g. busses. Ther=
e=20
>> might be drivers for devices on some specific bus. Each of them migh=
t=20
>> want to set latency constraint for the bus.
>
> In the case of bus wakeup latency, all of the on-chip interconnects s=
hare=20
> the same wakeup latency - the CORE powerdomain wakeup latency.  So=20
> set_max_dma_lat() covers all of the interconnect latencies.

Well I didn't mean interconnect busses here. I was thinking busses
like spi, which can have multiple devices on it. Drivers for theses
devices might want to set latency constraints for spi bus. In current
plan we are assuming that spi driver is the only one who sets the
latency constraint for spi bus. How could spi driver know what is the
spi latency requirement for the device that is connected to it?

>
> We could call it set_max_bus_wakeup_lat(), with a prototype similar t=
o=20
> set_max_dev_wakeup_lat(), for consistency. (The bus agent argument wo=
uld=20
> effectively be ignored in OMAP2/3.)

Lets not change that, originally it was planned to control sdma
latency constraint, without caring that it actually affects also to
interconnect bus latencies. Is this plan changed? At some point it was
thought to be changed to set_max_sdma_lat(), right?

If we are some day at point where interconnect busses are modelled as a
bus, then adding set_max_bus_wakeup_lat() could be good idea. Further
if also sdma will be modelled as a platform device, then
set_max_dma_lat() could be removed and set_max_dev_wakeup_lat() used
instead for sdma.

Currently set_max_intr_lat() could be already removed with adding one
more parameter to set_max_dev_wakeup_lat():

set_max_dev_wakeup_lat(struct device *dev, struct device *req, unsigned
long t);

This is just an idea, please do not change:) Instead I think your idea
to change it back to what it was is better at this point.

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
