From: "Chung-Wei Ruan" <cwruan@gmail.com>
Subject: problem about change recording source as line in of aic23 under
	2.6.18 with OMAP5912
Date: Mon, 13 Nov 2006 23:28:00 +0800
Message-ID: <34d819150611130728j5f55a44cs49cc783f10c19bb@mail.gmail.com>
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

Hi

I port kernel 2.6.18 to the OMAP 5912 and want to used the aic23 audio
device.
The default recording source on the aic23 is microphone input. But I wnat to
use
the line in as the input. According to the open sound system (OSS), I write
some
testing audio code, and can record the sound from MIC input, and play the
recording
sound from the headphone output.

I use the code as below to change the recording source to be line in, but it
can't work.

int mask = 0;
mask  |=  (1 << SOUND_MIXER_LINE);
ioctll(mixer_fd, SOUND_MIXER_WRITE_RECSRC, &mask);

The recording source is still the MIC. I tried to trace the
${KERNEL_SRC}/sound/oss/omap-audio-aic23.c.

    if((_IOC_DIR(cmd) & _IOC_WRITE) {
                ret = get_user(val, (int *)arg);
                if (ret)
                      goto out;

                switch (nr) {
                    case SOUND_MIXER_VOLUME:
                        aic23_local.volume = val;
                        aic23_local.mod_cnt++;
                        ret = aic23_update(SET_VOLUME, val);
                        break;

                    case SOUND_MIXER_LINE:
                        aic23_local.line = val;
                        aic23_local.mod_cnt++;
                        ret = aic23_update(SET_LINE, val);
                        break;

                    case SOUND_MIXER_MIC:
                        aic23_local.mic = val;
                        aic23_local.mod_cnt++;
                        ret = aic23_update(SET_LINE, val);
                        break;

                    case SOUND_MIXER_RECSRC:
                        break;
                    default:
                        ret = -EINVAL;
              }
          }

The case SOUND_MIXER_RECSRC do nothing.
So, can the aic23 change the recording source as the line in under arm linux
system?
Or if there is another method to change the recording source as the line in?

Thank you very much!!

B.R.
C.W.
