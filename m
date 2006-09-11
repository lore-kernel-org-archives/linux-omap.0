From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: omap5912 audio driver
Date: Mon, 11 Sep 2006 16:39:46 +0200
Message-ID: <45057532.5030603@gmail.com>
References: <BAY21-F1746C7EECAA525FB8B48FBF82A0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <BAY21-F1746C7EECAA525FB8B48FBF82A0@phx.gbl>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: zil iram <zil_iram@hotmail.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

zil iram wrote:
> When I compiled 
> the kernel (version 2.6.16) with the audio drivers enabled, an error 
> occured with this message :
>                sound/oss/omap-audio-aic23.c:246: error: unknown field 
> `sem' specified in initializer
> To move on with my work, I just commented out the line
>                .sem        = __SEMAPHORE_INIT(aic23_state.sem, 1)
> inside the structure static audio_state_t aic23_state of the file 
> specified in the error message.  So the kernel compiled. Do you know 
> what is wrong?

Can you try and check the same with recent kernel from git?

Dirk
