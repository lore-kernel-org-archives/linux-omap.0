From: "Komal Shah" <komal.shah802003@gmail.com>
Subject: Re: Problem in Running DSP/BIOS sample application in H3 board
Date: Wed, 20 Dec 2006 11:35:54 +0200
Message-ID: <3a5b1be00612200135v593abac3p8d5d52ca2125cf9b@mail.gmail.com>
References: <F6E1228667B6D411BAAA00306E00F2A50AE7379D@pdc2.nestec.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <F6E1228667B6D411BAAA00306E00F2A50AE7379D@pdc2.nestec.net>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: RENJITH G WARIER P V <RENJITHGWARIER@nestec.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 12/20/06, RENJITH G WARIER P V <RENJITHGWARIER@nestec.net> wrote:
> Hi,
>
> I have a problem in running the sample application in DSP/BIOS bridge and
> hope someone here could help me.
>
> I am trying to build DSP/BIOS Bridge in OMAP H3 Board running on Linux
> 2.6.9-omap1. I was able to build bridgedriver.ko, and both sides of the
> sample application(DSP side in CCs 2.21 and GPP side in linux). I then
> copied bridgedriver.ko, bridgedriver.o, strmcopy.out, strmcopy.dof55l(DSP
> side executable), installation script and the corresponding
> libraries(libbridge.so and libbridge.so.2). Then tried to run the same
>
>
>
> # ./install_bridge
>
> Using ./bridgedriver.ko
>
> bridgedriver: module license 'Texas Instruments Incorporated' taints kernel.
>

Sorry. Ask " 'Texas Instruments Incorporated' " for help, contacting
FAE. As it is binary only module. Please don't expect the answers for
the driver whose source is not available for us to see.

-- 
---Komal Shah
http://komalshah.blogspot.com
