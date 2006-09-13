From: "zil iram" <zil_iram@hotmail.com>
Subject: Re: omap5912 audio driver
Date: Wed, 13 Sep 2006 01:52:29 +0000
Message-ID: <BAY21-F78C8577736EB9F39B3493F8280@phx.gbl>
References: <45057532.5030603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <45057532.5030603@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: dirk.behme@googlemail.com
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Hi Dirk,
          Thanks, I tried using kernel 2.6.17 and the audio driver is now 
compiling and working.
           Thank you very much!
Zil

>From: Dirk Behme <dirk.behme@googlemail.com>
>To: zil iram <zil_iram@hotmail.com>
>CC: Linux-omap-open-source@linux.omap.com
>Subject: Re: omap5912 audio driver
>Date: Mon, 11 Sep 2006 16:39:46 +0200
>
>zil iram wrote:
>>When I compiled the kernel (version 2.6.16) with the audio drivers 
>>enabled, an error occured with this message :
>>                sound/oss/omap-audio-aic23.c:246: error: unknown field 
>>`sem' specified in initializer
>>To move on with my work, I just commented out the line
>>                .sem        = __SEMAPHORE_INIT(aic23_state.sem, 1)
>>inside the structure static audio_state_t aic23_state of the file 
>>specified in the error message.  So the kernel compiled. Do you know what 
>>is wrong?
>
>Can you try and check the same with recent kernel from git?
>
>Dirk

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
