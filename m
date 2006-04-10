From: ruchir.gulati@tcs.com
Subject: RE: Linux audio driver OMAP5912
Date: Mon, 10 Apr 2006 17:19:59 +0530
Message-ID: <OF3B663DF1.51750408-ON6525714C.003EC5FC-6525714C.0040F227@tcs.com>
References: <520AB2AD990DC04082102F77CA172638030C4EF6@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <520AB2AD990DC04082102F77CA172638030C4EF6@dlee03.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Menon, Nishanth" <x0nishan@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Hello,

Thanks for the help. Nishant's tip suggesting about sampling rate getting 
halved for stereo mode made file playback on the OMAP possible!!
Now I'm stuck with the other half. I'm not able to record audio through 
the microphone input. Although I have doe things as suggested in OSS.pdf, 
I am unable to make this work. I am including a snippet of my code which I 
am using to configure the sound card. 
Though it shows that active recording source is MIC, yet I'm unable to 
record after that. Also the MIC volume is coming as 27500, where as I 
guess the allowd values are between 0 and 100. Can anybody please tell me 
what the possible problem might be??

Its as follows:

       int fd_mixer = open("/dev/mixer", O_RDONLY);
       int fd = open("/dev/dsp", O_WRONLY);
       int format, mask = 0, vol = 0;
 
      if(fd_mixer == -1) {
         printf("Mixer Open Failure\n");
         return -1;
      }
 
      format = AFMT_S16_LE;
      if(ioctl(fd, SNDCTL_DSP_SETFMT, &format) == -1){
         printf("ioctl failure\n");
         return -1;
      }
 
     if(format != AFMT_S16_LE) {
        .... 
     format = 2;
     if(ioctl(fd, SNDCTL_DSP_CHANNELS, &format) == -1){

        .... 
   format = 8000;
   if(ioctl(fd, SNDCTL_DSP_SPEED, &format) == -1){
        ....
   if(format != 8000) {
        ....
   printf("Supported Fs = %d\n", format);

   if(ioctl(fd_mixer, SOUND_MIXER_READ_RECMASK, &mask) == -1){
     printf("ioctl failure\n");
   }
   if(mask & (1 << SOUND_MIXER_MIC)) {
     printf("Active i/p is MIC\n");
   }
   else if(mask & (1 << SOUND_MIXER_LINE)) {
     printf("Active i/p is LINE\n");
   }

   if(ioctl(fd_mixer, MIXER_READ(SOUND_MIXER_MIC),&vol) == -1) {
     printf("MIC volume read failure\n");
   }
   printf("MIC Volume = %d\n", vol);

   close(fd_mixer);

Thanks & Regards,
Ruchir Gulati


Notice: The information contained in this e-mail message and/or attachments to it may contain confidential or privileged information.   If you are not the intended recipient, any dissemination, use, review, distribution, printing or copying of the information contained in this e-mail message and/or attachments to it are strictly prohibited.   If you have received this communication in error, please notify us by reply e-mail or telephone and immediately and permanently delete the message and any attachments.  Thank you
