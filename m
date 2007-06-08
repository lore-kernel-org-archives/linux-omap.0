From: Vadim Lebedev <vadim@mbdsys.com>
Subject: Re: PROBLEMS WITH DNS
Date: Fri, 08 Jun 2007 20:36:04 +0200
Message-ID: <4669A194.8090108@mbdsys.com>
References: <c7af2a170706081023w25076e1eq4a791b02a977f9f@mail.gmail.com>
	<4669945F.5070708@mbdsys.com> <466997D9.7040909@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <466997D9.7040909@grupopie.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Paulo Marques <pmarques@grupopie.com>
Cc: linux-omap-open-source@linux.omap.com, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

Paulo Marques wrote:

> Vadim Lebedev wrote:
>
>> Eduardo Franceschini wrote:
>> [...]
>>
>>> I can get an IP, but when I go to /etc/resolv.conf , I don't have an 
>>> IP for
>>> DNS server... somebody know what to do?
>>
>> [...]
>> Maybe one why to do it is to modify kernale mode dhcp client to 
>> create a procfs entry containig info for resolv.conf
>> and have /etc/resolv.com  to be symlink to procfs entry
>
>
> I'd say this is just the opposite direction of where things seem to be 
> going nowadays.
>
> AFAICS, the current solution to this problem is to use initrd / 
> initramfs with a user-space dhcp client and nice script to get the DNS 
> information into /etc/resolv.conf.
>
> With this in place you can even drop the DHCP / NFS-root support from 
> the kernel and have it all done in user-space.
>
> This seems to be the current trend, and I wouldn't be surprised if the 
> options for IP auto config and NFS root were dropped from mainline in 
> the future.
>
Kernel mode dhcp client solutions allows muuch faster boot sequences...
for embedded stuff 15-20 secs boot speed advantage is important....

Vadim

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
