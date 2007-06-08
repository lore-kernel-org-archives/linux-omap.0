From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: PROBLEMS WITH DNS
Date: Fri, 08 Jun 2007 12:33:52 -0500
Message-ID: <46699300.8020108@gmail.com>
References: <c7af2a170706081023w25076e1eq4a791b02a977f9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <c7af2a170706081023w25076e1eq4a791b02a977f9f@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Eduardo Franceschini <edumontenegro@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Eduardo Franceschini stated on 6/8/2007 12:23 PM:
> I can get an IP, but when I go to /etc/resolv.conf , I don't have an
> IP for
> DNS server... somebody know what to do?
To my knowledge, the host resolution order can be configured in
nssswitch.conf.. If you have NIS/NIS+ you could use the same to update
the /etc/hosts from a file... or i think there is someway to configure
using LDAP also..
check any of your linux desktops on the network, see how it is
configured.. it will help u configure ur board too.. I dont know if the
dhcpd daemon would grab the dns server info and update etc files.. u
could check associated documentation too.. personally i hack up my
/etc/hosts and resolv.conf with values i know of..but that'd be quick
and dirty ;)
Regards,
Nishanth Menon
