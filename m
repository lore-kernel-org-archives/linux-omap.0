From: Kai Svahn <kai.svahn@nokia.com>
Subject: Re: AIC23 Codec Driver for DSP/BIOS
Date: Thu, 04 Jan 2007 11:33:44 +0200
Message-ID: <459CC9F8.7040107@nokia.com>
References: <7d8fdf6f0701032246i6f6e9579p680be097648a0d00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <7d8fdf6f0701032246i6f6e9579p680be097648a0d00@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Raghunandan Dhongadi <dk.raghu@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello,

ext Raghunandan Dhongadi wrote:
> Hello All,
>
> I have a OMAP2430 SDP. I am lookinf out for a AIC23 codec driver that
> is implemented on the DSP core (C64x+), is there some reference code
> available either on C5x ?
>
In my understanding such driver do not exist, not at least publicly. The 
HW codec initializations has been done on MPU side and then the SW 
codecs ran on DSP. Also the needed channels depending if EAC or McBSP 
has been used has been initialized either in MPU or DSP (certain McBSP 
case) side.

Cheers,
Kai
