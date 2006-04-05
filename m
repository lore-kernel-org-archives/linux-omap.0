From: Paul Mundt <paul.mundt@nokia.com>
Subject: Re: [PATCH] Convert OSS aic23 to mutex
Date: Wed, 5 Apr 2006 22:00:13 +0300
Message-ID: <20060405190013.GA5532@nokia.com>
References: <443407FB.2060304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <443407FB.2060304@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 05, 2006 at 08:10:03PM +0200, Dirk Behme wrote:
> --- ./sound/oss/omap-audio-aic23.c_orig	2006-04-05 20:02:22.000000000 +0200
> +++ ./sound/oss/omap-audio-aic23.c	2006-04-05 20:03:05.000000000 +0200
> @@ -243,7 +243,7 @@ static audio_state_t aic23_state = {
>          .hw_remove      =  __exit_p(omap_aic23_remove),
>          .hw_suspend     = omap_aic23_suspend,
>          .hw_resume      = omap_aic23_resume,
> -	.sem	    = __SEMAPHORE_INIT(aic23_state.sem, 1),
> +	.mutex	    = __MUTEX_INITIALIZER(aic23_state.mutex),
>  };
>  
>  /* This will be defined in the audio.h */
> 
Are you sure this doesn't need an #include <linux/mutex.h>? All of the
other conversions so far have..
