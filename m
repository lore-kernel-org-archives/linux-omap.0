From: "ahmed adel" <elakwah@gmail.com>
Subject: RF6 app.(osk5912)
Date: Sat, 1 Jul 2006 17:25:53 +0300
Message-ID: <6fbbb3de0607010725n2b342d9g237fa199b4e9840d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

the RF6 application of osk5912,

i want to configure it to get the sound
from mic not form (line in),

the configuration code on gpp side:

/*
 *  ======== configureCodec ========
 *  Configure the codec.
 */
static void configureCodec( int sampleFreq )
{
    int ioctlarg;

    /* Open the codec */
    codecFd = open( CODEC_DEV, O_WRONLY, 0 );

    if( codecFd == -1 ) {
        terminateThread( "Error: Failed to open audio driver", AUDIOSTATE0
);
    }

    /* Configure the bits/sample in the driver */
    ioctlarg = BITSPERSAMPLE;

    if( ioctl(codecFd, SNDCTL_DSP_SETFMT, &ioctlarg) == -1 ) {
        terminateThread( "Error: cannot set bits", AUDIOSTATE1 );
    }

    /* Configure the number of audio channels in the data stream */
    ioctlarg = STEREO;    // AIC23 is a stereo codec

    if( ioctl(codecFd, SNDCTL_DSP_CHANNELS, &ioctlarg) == -1 ) {
        terminateThread( "Error: cannot set channels", AUDIOSTATE1 );
    }

    /* Configure the speed of the data stream */
    ioctlarg = sampleFreq;

    if( ioctl(codecFd, SNDCTL_DSP_SPEED, &ioctlarg) == -1 ) {
        terminateThread( "Error: cannot set speed", AUDIOSTATE1 );
    }
    return;
}
