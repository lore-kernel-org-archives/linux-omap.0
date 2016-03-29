From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: am335x: no multicast reception over VLAN
Date: Tue, 29 Mar 2016 07:21:55 +0200
Message-ID: <CAGm1_ksxRPCAqx4n5gbsARSYeF116BT7r8cC6=1QYnEsYRxpVw@mail.gmail.com>
References: <CAGm1_ktOqB4QBMy2G4XeHTkaP+WvG8GOc8maVv3dDoxM+-F+ZA@mail.gmail.com>
 <56F9FDD0.8030504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <56F9FDD0.8030504@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: netdev <netdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, drivshin@allworx.com, grygorii.strashko@ti.com, ml@markusgrimm.de
List-Id: linux-omap@vger.kernel.org

Hi Mugunthan,

On Tue, Mar 29, 2016 at 6:00 AM, Mugunthan V N <mugunthanvnm@ti.com> wrote:
> Hi Yegor
>
> On Wednesday 16 March 2016 08:35 PM, Yegor Yefremov wrote:
>> I have an am335x based board using CPSW in Dual EMAC mode. Without
>> VLAN IDs I can receive and send multicast packets [1]. When I create
>> VLAN ID:
>>
>> ip link add link eth1 name eth1.100 type vlan id 100
>> ip addr add 192.168.100.2/24 brd 192.168.100.255 dev eth1.100
>> route add -net 224.0.0.0 netmask 224.0.0.0 eth1.100
>>
>> I can successfully send multicast packets, but not receive them. On
>> the other side of the Ethernet cable I've used Pandaboard. Pandaboard
>> could both receive and send multicast packets via VLAN.
>
> Are you trying multicast tx/rx on eth1 or eth1.100?

I'm trying multicast tx/rx on eth1.100.

eth1 has no problems.

Yegor

>> This setup was tested with both 3.18.21 and 4.5 kernels.
>>
>> Any idea?
>>
>> [1] https://pymotw.com/2/socket/multicast.html
>>
>
> --
> Regards
> Mugunthan V N
>
