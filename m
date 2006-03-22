From: Anoop Krishnan <Anoop.Krishnan@lntinfotech.com>
Subject: Re: Volume control in OMAP 1510
Date: Wed, 22 Mar 2006 17:32:49 +0530
Message-ID: <OFD1C8DE0A.FCB11C3F-ON65257139.0040FA60-65257139.00422D28@lntinfotech.com>
References: <fd1e34b0603220134q4b27474dr9e8742fd2cf28268@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <fd1e34b0603220134q4b27474dr9e8742fd2cf28268@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi James

I  enabled ALSA  in the sound driver. There you  have to enable OSS PCM 
API.

 Location:
     -> Device Drivers
       -> Sound 
         -> Advanced Linux Sound Architecture
           -> Advanced Linux Sound Architecture (SND [=y]) 



Also you should enable OMAP sound driver in OSS.

 Location: 
     -> Device Drivers 
       -> Sound 
         -> Open Sound System
           -> Open Sound System (DEPRECATED) (SOUND_PRIME [=y])
            -> OMAP Sound Driver (SOUND_OMAP [=y])


Anoop

______________________________________________________________________
