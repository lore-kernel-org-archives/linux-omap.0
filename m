From: Philip Balister <philip@balister.org>
Subject: Re: Current git and default config
Date: Wed, 11 Oct 2006 07:02:43 -0400
Message-ID: <452CCF53.40404@balister.org>
References: <452AB302.30507@balister.org> <20061011073304.GQ18091@earth.li>
	<85058BC1-FD83-42D9-BCF9-8EE3B87FEE4C@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <85058BC1-FD83-42D9-BCF9-8EE3B87FEE4C@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Khem Raj <kraj@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I think there are two issues:

1) The patch that allows compilation on the OSK without the dspgw is needed.

2) For the OSK, should the dspgw be in the default configuration? I 
think so.

Philip

Khem Raj wrote:
> 
> On Oct 11, 2006, at 12:33 AM, Jonathan McDowell wrote:
> 
>>
>> Does the patch at
>>
>> http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/ 
>> 008064.html
>>
>> fix the compilation issue for you if you don't change the config?
> 
> 
> FWIW It fixed the compilation issues for me using default config and  I 
> could build kernel and also boot it on osk5912 board.
> 
> Thanks
> 
> 
> Khem Raj <kraj@mvista.com>
> MontaVista Software Inc.
> 
> 
> 
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 
