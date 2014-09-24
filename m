From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v6 1/2] usb: rename phy to usb_phy in HCD
Date: Wed, 24 Sep 2014 23:31:11 +0400
Message-ID: <54231BFF.5070901@cogentembedded.com>
References: <37148636.BU5lT4M4eC@wasted.cogentembedded.com> <2300651.HNvMzB0aUB@wasted.cogentembedded.com> <20140924192806.GO17997@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140924192806.GO17997@saruman>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, Peter.Chen@freescale.com, stern@rowland.harvard.edu, swarren@wwwdotorg.org, thierry.reding@gmail.com, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, yoshihiro.shimoda.uh@renesas.com, linux-kernel@vger.kernel.org, antoine.tenart@free-electrons.com
List-Id: linux-omap@vger.kernel.org

Hello.

On 09/24/2014 11:28 PM, Felipe Balbi wrote:

>> From: Antoine Tenart <antoine.tenart@free-electrons.com>

>> The USB PHY member of the HCD structure is renamed to 'usb_phy' and
>> modifications are done in all drivers accessing it.
>> This is in preparation to adding the generic PHY support.

>> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
>> [Sergei: added missing 'drivers/usb/misc/lvstest.c' file, resolved rejects,
>> updated changelog.]
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> Acked-by: Alan Stern <stern@rowland.harvard.edu>

> Acked-by: Felipe Balbi <balbi@ti.com>

    Sorry, forgot to collect your ACK from the previous posting. :-/

WBR, Sergei
